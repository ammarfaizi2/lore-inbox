Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267437AbSLSB71>; Wed, 18 Dec 2002 20:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267447AbSLSB71>; Wed, 18 Dec 2002 20:59:27 -0500
Received: from holomorphy.com ([66.224.33.161]:32191 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267437AbSLSB71>;
	Wed, 18 Dec 2002 20:59:27 -0500
Date: Wed, 18 Dec 2002 18:05:52 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: Robert Love <rml@tech9.net>, Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 15000+ processes -- poor performance ?!
Message-ID: <20021219020552.GO31800@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Lang <david.lang@digitalinsight.com>,
	Robert Love <rml@tech9.net>, Till Immanuel Patzschke <tip@inw.de>,
	lse-tech <lse-tech@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <1040262178.855.106.camel@phantasy> <Pine.LNX.4.44.0212181743350.7848-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212181743350.7848-100000@dlang.diginsite.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 05:44:46PM -0800, David Lang wrote:
> In my case I will still be running thousands of processes, so I have to
> just teach everyone not to use top instead.
> David Lang

Well, a better solution would be a userspace free of /proc/ dependency.

Or actually fixing the kernel. proc_pid_readdir() wants an efficiently
indexable linear list, e.g. TAOCP's 6.2.3 "Linear List Representation".
At that point its expense is proportional to the buffer size and
"seeking" about the list as it is wont to do is O(lg(processes)).



Bill
