Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTJZSSw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 13:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263378AbTJZSSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 13:18:52 -0500
Received: from main.gmane.org ([80.91.224.249]:12192 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263375AbTJZSSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 13:18:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jochen Hein <jochen@jochen.org>
Subject: Re: Linux 2.4 <-> 2.6 compatibility
Date: Sun, 26 Oct 2003 19:18:48 +0100
Message-ID: <87fzhfsvzr.fsf@echidna.jochen.org>
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org> <20031026150544.GJ15838@merlin.emma.line.org>
 <871xt0ouei.fsf@echidna.jochen.org>
 <Pine.LNX.4.58.0310261844580.8636@trider-g7.ext.fabbione.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
Cancel-Lock: sha1:CO5u+NkD0eGMaQMRrYaGu3HcQW0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Massimo Di Nitto <fabbione@fabbione.net> writes:

> On Sun, 26 Oct 2003, Jochen Hein wrote:
>
>> Matthias Andree <matthias.andree@gmx.de> writes:
>>
>> > As 2.6 starts stabilizing, PLEASE try to synch up major components of
>> > 2.6 and 2.4 so that the same user space can be used for either version.
>> > It's fine with modutils and stuff, but when it comes to LVM, these 2.4
>> > and 2.6 versions are a problem.
>>
>> Debian SID contains lvm10, lvm2 and lvm-common, which can be installed
>> together and work for both kernels.  Backport to woody was simple.
>
> this is true in terms of userland utils but you still need to perform a
> transition of kernels. 2.4 -> 2.4 + devicemapper patch -> 2.6. 

No, I just did install 2.6 on my formerly 2.4-vanilla system!

> Until now i
> couldn't find a way to jump directly from 2.4 to 2.6 and converting from
> lvm1 to lvm2 at the same time.

lvm-common contains a program that decides what
iop-version/lvm-version/dm-version is running and calls the right
userland.  So you have e.g.:
/sbin/vgchange: link to lvmiopversion.  That decides to call
/lib/lvm-10/vgchange or /lib/lvm-2/vgchange depending on the kernel
stuff.  Very helpful for me.

Jochen

-- 
#include <~/.signature>: permission denied

