Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWBMUEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWBMUEE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWBMUEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:04:04 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:14603 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964839AbWBMUEC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:04:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060213115248.2f6445f4.akpm@osdl.org>
X-OriginalArrivalTime: 13 Feb 2006 20:03:47.0158 (UTC) FILETIME=[996A2F60:01C630D8]
Content-class: urn:content-classes:message
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
Date: Mon, 13 Feb 2006 15:03:46 -0500
Message-ID: <Pine.LNX.4.61.0602131501320.17371@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 02/13] hrtimer: remove useless const
thread-index: AcYw2JlzC4LxccubSZeEwgPVGLBvDw==
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home><1139830116.2480.464.camel@localhost.localdomain><Pine.LNX.4.61.0602131235180.30994@scrub.home><20060213114612.GA30500@elte.hu><20060213035354.65b04c15.akpm@osdl.org><Pine.LNX.4.61.0602131315150.30994@scrub.home><20060213043038.25a49dd0.akpm@osdl.org><Pine.LNX.4.61.0602131339330.30994@scrub.home> <20060213115248.2f6445f4.akpm@osdl.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "Roman Zippel" <zippel@linux-m68k.org>, <mingo@elte.hu>,
       <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Feb 2006, Andrew Morton wrote:

> Roman Zippel <zippel@linux-m68k.org> wrote:
>>
>> On Mon, 13 Feb 2006, Andrew Morton wrote:
>>
>> > const arguments to functions are pretty useful for code readability and
>> > maintainability too, if you use them consistently.
>>
>>  I could understand that argument, if gcc would warn about it in any way.
>
> It does.  If a function tries to modify a formal argument which was marked
> const you'll get a warning.
>
> We're talking about different things here.  My point is that it is
> perverted and evil for a function to modify its own args (unless it's very
> small and simple), and a const declaration is a useful way for a
> maintenance programmer to be assured that nobody has done perverted and
> evil things to a function.
> -

This is evil????

void foo(int len)
{
     while(len--)
         do_something();
}

I don't think so. The function already owns "len". Why should it
create another copy?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
