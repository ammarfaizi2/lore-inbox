Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267403AbSLSBT1>; Wed, 18 Dec 2002 20:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267437AbSLSBT1>; Wed, 18 Dec 2002 20:19:27 -0500
Received: from holomorphy.com ([66.224.33.161]:14015 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267403AbSLSBTY>;
	Wed, 18 Dec 2002 20:19:24 -0500
Date: Wed, 18 Dec 2002 17:25:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Lang <dlang@diginsite.com>
Cc: Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 15000+ processes -- poor performance ?!
Message-ID: <20021219012549.GK31800@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Lang <dlang@diginsite.com>,
	Till Immanuel Patzschke <tip@inw.de>,
	lse-tech <lse-tech@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20021219011541.GI31800@holomorphy.com> <Pine.LNX.4.44.0212181711200.7848-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212181711200.7848-100000@dlang.diginsite.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 05:12:41PM -0800, David Lang wrote:
> also top is very inefficant with large numbers of processes. use vmstat
> or cat out the files in /proc to get the info more efficiantly (it won't
> get you per process info, but it son't cause the interferance with your
> desired load that top gives you.)

It's mostly just the fact top(1) doesn't scan /proc/ incrementally and
that proc_pid_readdir() is quadratic in the number of tasks.


Bill
