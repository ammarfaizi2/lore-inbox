Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUFRN4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUFRN4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 09:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbUFRN4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 09:56:00 -0400
Received: from hades.almg.gov.br ([200.198.60.36]:30685 "EHLO
	hades.almg.gov.br") by vger.kernel.org with ESMTP id S265141AbUFRNzz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 09:55:55 -0400
Message-ID: <40D2F463.6090104@almg.gov.br>
Date: Fri, 18 Jun 2004 10:55:47 -0300
From: Humberto Massa <humberto.massa@almg.gov.br>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.8a1) Gecko/20040520
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: debian-legal@lists.debian.org
CC: debian-kernel@lists.debian.org, debian-devel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: How long is it acceptable to leave *undistributable* files in
 the kernel package?
References: <o0_liB.A.TFG.4fu0AB@murphy>
In-Reply-To: <o0_liB.A.TFG.4fu0AB@murphy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I apologize for the cross-posting to linux-kernel, but this seems
relevant to me (even if it comes from debian- lists) to the kernel
developers as a whole.


@ 18/06/2004 10:02 : wrote Brian Thomas Sniffen :

 >Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> writes:
 >
 >>The firmware typically wasn't patched, and nothing is derived from
 >>it.
 >
 >
 >Isn't the kernel containing the firmware derivative of it?  If not,
 >why can't I put some GPL-incompatible x86 code into the kernel,
 >load it into a device in my system -- the main memory -- and then
 >issue a command to the processor to execute it?
 >
 >That is, doesn't your interpretation allow arbitrary linking of
 >GPL'd programs?
 >
 >I would be much more convinced if I saw an argument from the
 >GPL-incompatible-firmware-is-OK side as to why the GPL prohibits
 >distributing linkages of GPL'd and GPL-incompatible code.
 >
 >-Brian
 >

you see, I was starting to have doubts myself in the "no non-GPL
linkage" clause of the GPL (yes, it's there, it is the last
paragraph of http://www.gnu.org/licenses/gpl.txt -- and is
authoritative because of the other arguments below, read on...)

What rights do the GPL'd software recipient have? The GPL grants
some rights not granted by copyrights law. I made an extensive
document and posted it to d-l, but no-one seemed to listen or to
understand. All ok. IRT making derived works, the recipient has the
right of making *some* derived works (respecting 2a and 2c) and to
redistribute those derived works under the terms of the GPL itself.
It seems not to permit anthology (collective) works, until you see
the "mere aggregation" clause (section 2 third paragraph) /which/
appears to cover anthology works.

So now, we have to decide where is the line dividing where the "mere
aggregation" is "compiling" (in the "making an anthology" sense) and
not "deriving". But wait, in the "how to use the GPL" thing, the
very last paragraph explains that linking is to be considered making
a derived work.

This bears none or almost none consequence for a single copyright
holder, but for a multi-copyrighted, multi-type (original, derived,
anthologic) work like the Linux kernel, it explains that if you want
a license to the kernel, *and* your work links to the kernel, *and*
your work is not original [1], *then* you will consider your work a
derivative work of the kernel.

[1] perfectly possible case of a BSD LKM that does not need glue
code in the Linux kernel to link, possibly because the needed glue
code was already there for some _other_ reason. The other
(controversial) example is the nvidia drivers, that distribute under
the GPL the glue code and use a binary (non-derived-from-the-kernel)
driver as the workhorse.
 
But wait; firmware is *not* linking with the kernel, as the icons
are *not* linking with emacs.  Or are they? What is linking? If you
consider linking to give names fixups and resolving them, well, the
char tg3_fw[] = ... is linked with the kernel all right. If you
consider that a call (as in the asm CALL opcode sense) must be made,
it's not. The firmware does not "execute", at least in the main CPU.
Anyway, the non-GPL-compatibly-licensed icon in your previous emacs
example is *most* *certainly* not linking with emacs (in the
ld-or-ld.so sense) and it's OK.

The (simplified) answer: the GPL "do not link" is weak because of
the "mere aggregation clause" and because of the dichotomy between
derivative and anthology works; it's weaker in the case of the
binary kernel modules, especially if they are not distributed with
the kernel (the linking is done at the end user, where many things
are possible); it's even weaker in the case of firmware (because
firmware does not /properly/ link in the software sense, even if it
*does* link in the ld-or-ld.so sense); it's really faint in the case
of an accompanying icon or image (or movie: eMovix comes to mind).

Please refer to

http://lists.debian.org/debian-legal/2004/06/msg00361.html

for an explanation of how IMHO are the original/anthology/derivative
relations are formed to get to the current linux kernel.

I hope I have helped this discussion.

--
br,M



