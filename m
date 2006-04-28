Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWD1MAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWD1MAc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 08:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbWD1MAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 08:00:32 -0400
Received: from spirit.analogic.com ([204.178.40.4]:16655 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030304AbWD1MAa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 08:00:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4451DF24.20408@argo.co.il>
X-OriginalArrivalTime: 28 Apr 2006 12:00:23.0759 (UTC) FILETIME=[549C35F0:01C66ABB]
Content-class: urn:content-classes:message
Subject: Re: C++ pushback
Date: Fri, 28 Apr 2006 08:00:17 -0400
Message-ID: <Pine.LNX.4.61.0604280740040.7266@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: C++ pushback
thread-index: AcZqu1SlsYJ0ETBRQ4+NHuszFIHf3g==
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de> <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org> <20060426201909.GN27946@ftp.linux.org.uk> <20060426213700.GB22894@mars.ravnborg.org> <4451DF24.20408@argo.co.il>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Avi Kivity" <avi@argo.co.il>
Cc: "Sam Ravnborg" <sam@ravnborg.org>, "Al Viro" <viro@ftp.linux.org.uk>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Jan-Benedict Glaw" <jbglaw@lug-owl.de>, <linux-kernel@vger.kernel.org>,
       "David Schwartz" <davids@webmaster.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Apr 2006, Avi Kivity wrote:

> Sam Ravnborg wrote:
>> The original question was related to port existing C++ code to be used
>> as a kernel module.
>> Magically this always ends up in long discussions about how applicable
>> C++ is the the kernel as such which was not the original intent.
>>
>> So following the original intent it does not matter what subset is
>> sanely used, only what adaptions is needed to kernel proper to support
>> modules written in C++.
>>
>>
>
> Here at last is a sane response. If the kernel were enhanced/bastardized
> (pick one) to support C++ modules, we could evaluate how C++ actually
> does in terms of runtime and developer performance.
>
>> But I have seen no patches this time either, so required modifications
>> are yet to be identified.
>>
>
> Since such patches are sure to be rejected (apparently renaming 'struct
> class' would wreak havoc on the development process), I doubt that they
> will appear. Not to mention the attacks on the submitters that would follow.
>

I'm fairly sure that if header structure members were renamed (one
patch at a time), and were renamed sanely (like struct class should not
be renamed to struct TheyDidntKnowAnything)... and sanely also means
trying to have the same length like (struct klass)...and if every file
that included those headers were updated.... I think the patches would
not be rejected, especially if Linus said, "Let's get rid of the
C++ keywords."

It is well known that in a few years you won't be able to find a 'C'
compiler or C++ for that matter. Everything will be written in Z##
or whatever. The problem I see is that newcomers, who have only
learned one language, assume that they have some special enlightenment
and that 'C' is wrong. Simple changes that let these newcomers experiment,
perhaps finding the errors of their ways, as long as they are not
harmful, should not be discouraged.

Maybe it's fork time, but maybe not. There seem to be very few C++
keywords being used although, where they are used, affect many files.
If it was my ballgame, I'd let the C++ advocates submit patches to
remove those keywords. Then, after they get their first module
to load, they will learn the errors of their ways as they find
that there isn't enough RAM available to do any useful work. But,
at least the "bad" words will have been removed from the headers
by highly motivated programmers. The cost is zero.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
