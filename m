Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263668AbREYJev>; Fri, 25 May 2001 05:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263670AbREYJel>; Fri, 25 May 2001 05:34:41 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:57744 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S263668AbREYJea>; Fri, 25 May 2001 05:34:30 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 25 May 2001 02:34:24 -0700
Message-Id: <200105250934.CAA23240@adam.yggdrasil.com>
To: acahalan@cs.uml.edu
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
Cc: aaronl@vitelus.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> = Aaron Lehmann <aaronl@vitelus.com>.
>  = Albert D. Cahalan <acahalan@cs.uml.edu>

>> 	I believe this infringinges the copyrights of the authors
>> of the code used in these drivers who released their code under GPL.
>> Alan Cox, has gone on a campaign claiming that this is "mere aggregation"

>As far as the Linux kernel is concerned, firmware images are
>not software at all. They are large magic numbers that must
>be written to the hardware. (they don't execute on your CPU)

>If a driver writes 0x63f30e44 (4 bytes) to the card, no problem?
>Fine, how about 0x52e590a84fc8231e (8 bytes) then? You can see
>where this is leading I hope: 200 kB is perfectly fine.

>It's obviously not size that matters. What matters is that Linux
>doesn't transfer control into the firmware; that is, Linux does
>not do a jump into firmware like this:

>goto *((void*)firmware);

	I have never heard of this legal standard.  A reference
to some section of Title 17 in the United States Code (copyright), a
relevant court precedent, etc. would be appreciated.

	I am not a lawyer, so please do not use this as legal advice.

	A software "license" typically grants you permission to do
things that you would not otherwise be allowed to do with a
copyrighted work in the absense of any permission (such as make a copy
in most cases), provided that you meet certain conditions.  Those
conditions could be nearly anything.  They're not necessarily limited
to what is restricted by copyright.  I used to think it was so limited
due to copyright preemption of state law by title 17 of US Code section
301, http://www4.law.cornell.edu/uscode/17/301.html, but apparently
this does not appear to be so according, for example, to
http://www.richmond.edu/~jolt/v1i1/hardy.html#fn13, which references
"Hines v. Davidowitz, 312 U.S. 52, 67 (1941), reaffirmed in Sears,
Roebuck & Co. v. Stiffel Co., 376 U.S. 225, reh'g denied, 376 U.S.
973 (1964)", which I HAVE NOT READ, but I have read other things about
this question and this just happens to be what I could dig up in a few
seconds on google.

	If I recall correctly, doing something that is only legal if
you had accepted an agreement is acceptance according to some
provision of the uniform commercial code.  (No, it's not new.  I think
at http://www.law.cornell.edu/ucc/2/2-206.html, section 1a, and the
definition of goods to include "goods in action" in
http://www.law.cornell.edu/ucc/2/2-105.html#Goods_2-105).

	From this, I hope we can agree that is possible to write
copying conditions that prohibit make any copies of certain free
software contained in the keyspan_usa drivers if the keyspan_usa firmware is
also distributed in the same driver ".o" file, and that the question
is simply whether the GPL does so.

	So, Albert, are you claiming that the FSF intended to allow a
GPL'ed .o file that contains proprietary firmware for another
microprocessor or are you claiming that FSF made a drafting error in
the writing the GPL?

	If you believe you have found an error in the GPL, do you
think a court would let you out of it given the four corners rule
(basically using evidence of the understood meaning of an agreement to
interpret what was actually written down)?

	On the question of whether this is nothing more than
aggregation, the firmware works intimately with the device driver to
produce a unitary result.  The part of the driver that runs in the
device and the CPU side speak a mutually agreed upon protocol, and the
unitary result is that you do not have to preload the firmware as
earlier versions of the driver required.  You actually have to do some
kernel development to remove the code.  It's not simply the case that
you could just skip distribution of an extra file and have the rest of
the functionality work.  In fact, even if you zeroed out the
microcode, you would still not get the result of having the driver
work (e.g., if you had loaded the code originally).  Instead, the
driver would fill the device with all zeroes.  Greg Kroah-Hartman has
already said he thinks removal is complicated enough that he does not
want to voluntarily do it in 2.4.  For these reasons, this situation
is not just shipping two works next to each other (mere aggregation).

	I hope it should be clear now that the GPL can and does
prohibit #include'ing this and that it is not mere aggregation.

	I also hope that people understand that while I think the
stability argument for not including my fix in 2.4 (which everyone
seems to like technically) is BS, I would be satisfied if the
keyspan_usa drivers were now released under GPL-compatible copying
conditions.  However, it has now been weeks this has not been done.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
