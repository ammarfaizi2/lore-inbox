Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263042AbUB0QmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 11:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263043AbUB0QmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 11:42:20 -0500
Received: from mxout2.iskon.hr ([213.191.128.16]:43734 "HELO mxout2.iskon.hr")
	by vger.kernel.org with SMTP id S263042AbUB0QmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 11:42:18 -0500
X-Remote-IP: 213.191.128.14
X-Remote-IP: 213.191.128.21
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Jochen Roemling <jochen@roemling.net>, linux-kernel@vger.kernel.org
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
References: <1tCuq-3AH-1@gated-at.bofh.it> <1tCEo-3Lh-27@gated-at.bofh.it>
	<1tDgT-4r2-13@gated-at.bofh.it> <403E87CF.1080409@roemling.net>
	<20040226160616.E1652@build.pdx.osdl.net>
	<20040226163236.M22989@build.pdx.osdl.net>
	<403E958B.6020406@roemling.net> <20040227011151.GT693@holomorphy.com>
	<403E9E54.6030404@roemling.net> <dnad34xz2p.fsf@magla.zg.iskon.hr>
	<20040227163546.GB655@holomorphy.com>
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Fri, 27 Feb 2004 17:42:16 +0100
In-Reply-To: <20040227163546.GB655@holomorphy.com> (William Lee Irwin, III's
 message of "Fri, 27 Feb 2004 08:35:46 -0800")
Message-ID: <dn65dsxymv.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> On Fri, Feb 27, 2004 at 05:32:46PM +0100, Zlatko Calusic wrote:
>> Of course! Appended simple patch is what i did (ugly, I know) and that
>> helped me install Oracle10g on Debian unstable (with two other
>> adaptations). I don't know how in the hell I forgot to put that
>> important patch on my page where I explain how to install Oracle10g on
>> Debian?! Sorry, it'll be on http://linux.inet.hr/oracle10g_on_debian.html
>> later today or tomorrow, after I check some other problems people have
>> reported to me (and you Jochen, too :)).
>
> You have to be a bit more careful than this; this gives any user the
> ability to consume locked memory via shmget().

Yes, I know! But hopefully this security implication is not so
important for people who just want to test new database on their
workstations (like me), or even install it on the production database
server where you mostly don't see any other shell user beside the
administrator of the machine.

But yes, you're right, we need to warn people.

DON'T use the patch if you have untrusty shell users on your machine!!!

-- 
Zlatko

P.S. Although, if superuser properly limits the number of hugepages
     that can be allocated (echo "valid nr of pages" > nr_hugepages)
     what does attacker do to consume more pages than that? Just
     curious...
