Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130309AbRALTWy>; Fri, 12 Jan 2001 14:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131152AbRALTWo>; Fri, 12 Jan 2001 14:22:44 -0500
Received: from minster.cs.york.ac.uk ([144.32.40.2]:13043 "EHLO
	minster.cs.york.ac.uk") by vger.kernel.org with ESMTP
	id <S130309AbRALTWi>; Fri, 12 Jan 2001 14:22:38 -0500
From: "Laramie Leavitt" <lar@cs.york.ac.uk>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Date: Fri, 12 Jan 2001 19:19:49 -0000
Message-ID: <NEBBKCNHIKGLMACGICIGKEKDCCAA.lar@cs.york.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010112195715.A30496@athlon.random>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jan 12, 2001 at 10:35:24AM -0800, Linus Torvalds wrote:
> > Andreas argument was that earlier kernels weren't consistent, and as
> > such we shouldn't even bother to try to make newer kernels consistent. 
> > We would be better off reporting our internal inconsistencies the way
> > earlier kernels did - the kernel would be confusing, but at least it
> > would be consistently confusing ;)
> 
> The earlier kernels were 98% consistent in providing the 
> "cpu_has" information
> via /proc/cpuinfo that is true information too.
> 
> What I am suggesting is to fix the few places to make the 
> /proc/cpuinfo 100%
> consistent reporting "cpu_has", and to provide the "can_I_use" 
> information in
> another place (for example with /proc/osinfo or a new "osflags" row in
> /proc/cpuinfo).
> 
> This way we are 100% consistent and we don't lose the "cpu_has" 
> information.
> 

Yes, but why?  If the features cannot be used by userspace, then 
2.2 should be fixed to use the current model.  If someone wants
the information about the cpu that is not provided by the 'cpu_allows'
(My view of 'can_I_use' ) can't they just do a 'cpuid' and get
it for themselves anyway?

Laramie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
