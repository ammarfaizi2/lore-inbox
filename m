Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318713AbSHWI1L>; Fri, 23 Aug 2002 04:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318714AbSHWI1L>; Fri, 23 Aug 2002 04:27:11 -0400
Received: from h-64-105-137-141.SNVACAID.covad.net ([64.105.137.141]:42130
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318713AbSHWI1K>; Fri, 23 Aug 2002 04:27:10 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 23 Aug 2002 01:31:09 -0700
Message-Id: <200208230831.BAA02426@adam.yggdrasil.com>
To: andre@linux-ide.org
Subject: Re: IDE-flash device and hard disk on same controller
Cc: ebiederm@xmission.com, jgarzik@mandrakesoft.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2002, Andre Hedrick wrote:
>On Thu, 22 Aug 2002, Adam J. Richter wrote:

>> 	1. Regardless of whatever specification you are referring to
>> or Andre's "31 second rule of [Power On Self Test]", it is genuinely
>> useful to boot faster by overlapping some other kernel work before the
>> drive is.  Specifications ultimately exist only to serve this
>> usefulness.  When a specification impedes usefulness, sometimes it's
>> the right decision to violate it.  Of course, we're not talking about

>Listen to yourself, and understand why 2.5 failed.

>"When a specification impedes usefulness, sometimes it's the right
>decision to violate it."

>"Gee there is no traffic in the on coming lanes, maybe I should use them."

>There are rules for how the hardware works, and if everything out there
>comes up in 4 seconds great.  If everything returns faster than the worst
>case great.  You start assuming everything behaves that way and you repeat
>history.

>You guys in 2.5 walked away from the rules because you thought you knew
>better, where did it get you?  Lost interrupts, PIO command block
>exectution failures, dropping EOT on PRD's because reading something into
>the published documents which is not there, etc ...


	Those are not examples of cases where the specification impedes
usefulness.  Those are examples where a specification helped usefulness
by helping compatability (not driving in oncoming lanes, not having timing
problems), and a decision made either out of recklessness (driving into
oncoming lanes) or, I infer, out of a misunderstanding of some document.

	However, your point is well taken in that when I said
"sometimes it's the right decision to violate [a specification]," I
did not mean by "sometimes" that this is a random event, like
"sometimes it rains."  I meant that it's a very careful decision, the
details of which differ from case to case, and that the result is not
always against.


>> your IDE code violating such a specification, but rather not relying
>> on this particular guarantee.
>> 
>> 	2. Besides, if this code is supposed to be a generic IDE core,
>> it many need to run on platforms that do not provide that guarantee or
>> where the boot code is not even capable of finding where all of the
>> IDE controllers.

>It is a means for probing signatures w/o identify to test for presence.
>It to has a 31 second rule.  Break the worst case and device get lost.

	Can you provide a reference for this "31 second rule?"  If
your reference does not directly discuss how it would impede the test
that you refer to, then you might want to explain that too.  Thanks in
advance.

>Please do not take this personal, because it is a technical arguemnet.

	Of couse, likewise.

>We do it by the books and then we cheat when we can, but only after we
>have all the proper stuff in place for compliance.

	Let's keep in perspective that I am talking adding a test that
would cause a delay until it is safe to proceed (unless you're saying
that waiting for the busy bit to clear is insufficient, in which case
I'd like to know how, but it would still be no more dangerous), and
you are advocating skipping that test.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

	

