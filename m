Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262710AbREYRC2>; Fri, 25 May 2001 13:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262713AbREYRCR>; Fri, 25 May 2001 13:02:17 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:63445 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262710AbREYRCK>; Fri, 25 May 2001 13:02:10 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 25 May 2001 10:02:08 -0700
Message-Id: <200105251702.KAA23819@adam.yggdrasil.com>
To: dledford@redhat.com
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
Cc: aaronl@vitelus.com, acahalan@cs.uml.edu, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
>"Adam J. Richter" wrote:

>>         On the question of whether this is nothing more than
>> aggregation,

>Yes, on that very question, I would argue it is a mere aggregation.

>> the firmware works intimately with the device driver to
>> produce a unitary result.

>Irrelevant.

        The 1991 Abridged 6th Edition of _Black's Law Dictionary_
defines "aggregation" thusly (unfortunately, talking in terms of
patent law, but it is the most authoratitive definition I have found
so far):

        Aggregation: The combination of two or more elements in patent claims,
        each of which is unrelated and each of which performs separately and
        without cooperation , where combination does not define a composite
        integrate mechanism.  Term means that the elements of a claimed
        combination are incapabile of co-operation to produce a unitary
        result, and in its true sense does not need prior art patents to
        support it.


	If you want to argue that a court will use a different definition
of aggregation, then please explain why and quote that definition.  Also,
it's important not to forget the word "mere."  If the combination is anything
*more* than aggregration, then it's not _merely_ aggregation.  So,
if you wanted to argue from the definition on webster.com:

	1 : a group, body, or mass composed of many distinct parts
	    or individuals
        2 a : the collecting of units or parts into a mass or whole
	  b : the condition of being so collected

	You have to argue that absolutely nothing more than this
is being done.  For example, the code the parts are not working
together.

>All drivers work with some sort of firmware on their respective
>targets to produce a unitary result, even if that firmware is implemented with
>silicon (as a ROM BIOS that loads the proper firmware code, or as
>microcode/state hardware built into the chip(set) itself).  As a closely
>similar device, think about the 1542 SCSI controller.  [...]

	Yes.  It would also be illegal to distribute a GPL'ed driver
.o that #include'd that proprietary firmware.

>>  You actually have to do some
>> kernel development to remove the
>> [proprietary firmware from the keyspan_usa drivers].


>That's because you are assuming that uploading garbage to the device is not an
>option.

	No.  If I you change the driver to upload garbage, your
userland loader that just looks for the unitialized device ID will
not be able to get to the uninitialized device before the device
driver claims the interface and trashes it.  So, your supposed act of
disaggregation by zeroing out the effected bytes did not fully
restore the old functionality.

	By the way, I'm pretty sure that the situation is even
worse.  The modified driver would not just load garbage to the
ezusb device.  It would tell the ezusb device to jump to it, so
you would not be able to talk to it after that point, other than
by telling the kernel to reset the hub port that the ezusb device
is connected to, in which case, the keyspan_usa driver will again
grab the device and trash it.

	I would also argue that searching for a lengthy bit string
in file format and carefully zeroing it out is enough complexity
so that the connection between the two pieces of information (the
firmware integrated in the .o and the rest of the .o) are more
than just aggregation.

	I'm not denying that you could imagine a case that is a gray
area where the FSF's understood intention in writing the GPL as
interpreted by a judge from the GPL _and other evidence_ under the
four corner's rule may have been to allow it, but I don't think
we're anywhere near it.  But I agree that one could find some
point where it's a judgement call.  If you get sued and the judge
agrees with the plaintiff, you can lose your house, you life's savings,
etc.  in statutory damages at, I believe, $50k per act of copying.
If the judge agrees with you, well, then you have the satisfaction
of winning that argument.  I hope you appreciate the asymmetry of
the risk and have similarly calibrate your standards for caution,
at least when you advocate exposing others to these kinds of risks.

>> you could just skip distribution of an extra file and have the rest of
>> the functionality work. 

>That is exactly the case.  The only change that must be made to remove that .h
>file from the driver source is to tell the driver where the *new* location of
>the correct firmware is.

	What do you mean "remove the .h file" from the .o and
"tell the driver" (open your mouth and talk to the screen?).
We are talking about a .o file.  Copying the .o file is the
act of infringement.

	Also, if you're going to respond further, please also
answer the following question.  Are you claiming that the FSF intended
to allow a GPL'ed .o file that contains proprietary firmware for another
microprocessor or are you claiming that FSF made a drafting error in
the writing the GPL?

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
