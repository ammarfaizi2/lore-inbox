Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130807AbQKJSwq>; Fri, 10 Nov 2000 13:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131477AbQKJSwg>; Fri, 10 Nov 2000 13:52:36 -0500
Received: from [64.64.109.142] ([64.64.109.142]:27151 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S131437AbQKJSwR>; Fri, 10 Nov 2000 13:52:17 -0500
Message-ID: <3A0C435C.A31A38EC@didntduck.org>
Date: Fri, 10 Nov 2000 13:50:04 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de
CC: "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: CPU detection revamp (Request for comments)]
In-Reply-To: <Pine.LNX.4.21.0011101751080.514-100000@neo.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de wrote:
> 
> Hi hpa,
> 
>  First test, the AMD K6-2.
>
> Also, look at the feature flags:
> before:
> flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow
> 
> after:
> features        : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
> 
> Note, I lost MTRR & sep. This may be related to the stepping bug
> though. I'll recompile a kernel with the &15 fix, and see if that cures
> all.

The K6's don't support sysenter/sysexit.  It really should have been
marked differently before.  The early K6's used extended bit 10 to
indicate syscall/sysret capabality, but this version has some quirks
that make it pretty much unusable.  Later K6's use extended bit 11 to
indicate syscall/sysret.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
