Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267620AbSLSKYM>; Thu, 19 Dec 2002 05:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbSLSKYM>; Thu, 19 Dec 2002 05:24:12 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:41476 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267620AbSLSKYE>; Thu, 19 Dec 2002 05:24:04 -0500
Message-Id: <200212191015.gBJAFss28329@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: William Lee Irwin III <wli@holomorphy.com>,
       David Lang <david.lang@digitalinsight.com>
Subject: Re: [Lse-tech] Re: 15000+ processes -- poor performance ?!
Date: Thu, 19 Dec 2002 13:05:03 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Robert Love <rml@tech9.net>, Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
References: <1040262178.855.106.camel@phantasy> <Pine.LNX.4.44.0212181743350.7848-100000@dlang.diginsite.com> <20021219020552.GO31800@holomorphy.com>
In-Reply-To: <20021219020552.GO31800@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 December 2002 00:05, William Lee Irwin III wrote:
> On Wed, Dec 18, 2002 at 05:44:46PM -0800, David Lang wrote:
> > In my case I will still be running thousands of processes, so I
> > have to just teach everyone not to use top instead.
> > David Lang
>
> Well, a better solution would be a userspace free of /proc/
> dependency.
>
> Or actually fixing the kernel. proc_pid_readdir() wants an
> efficiently indexable linear list, e.g. TAOCP's 6.2.3 "Linear List
> Representation". At that point its expense is proportional to the
> buffer size and "seeking" about the list as it is wont to do is
> O(lg(processes)).

A short-time solution: run top d 30 to make it refresh only every 30 seconds.
This will greatly reduce top's own load skew.
--
vda
