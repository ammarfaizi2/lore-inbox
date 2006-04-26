Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWDZUFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWDZUFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWDZUFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:05:23 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:30987 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932385AbWDZUFX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:05:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com>
X-OriginalArrivalTime: 26 Apr 2006 20:05:19.0481 (UTC) FILETIME=[BE2F8E90:01C6696C]
Content-class: urn:content-classes:message
Subject: RE: C++ pushback
Date: Wed, 26 Apr 2006 16:05:19 -0400
Message-ID: <Pine.LNX.4.61.0604261553570.316@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: C++ pushback
thread-index: AcZpbL45YYnTf/Q6Q+Kq6qwabfGfkA==
References: <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "David Schwartz" <davids@webmaster.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Apr 2006, David Schwartz wrote:

>
>>> 	As for remembering new names, that's a load of complete crap and I
>>> find it hard to believe that you're raising the argument for honest
>>> reasons.
>
>> The scale of the kernel, the number and churn of developers, and the
>> importance of not breaking things in a stable kernel tend to argue
>> against you.  Humans develop the kernel.  Humans remember names well.
>> You may think that's arbitrary, but when you change naming across the
>> entire kernel, you confuse a very large and diverse group of people who
>> do this because they enjoy it.  It's hard enough when this has to happen
>> for useful or necessary reasons; you're asking the kernel developers to
>> accept it for a completely arbitrary whim that they have rejected
>> successfully several times in the past.
>
> 	C++ has how many additional reserved words? I believe the list is delete,
> friend, private, protected, public, template, throw, try, and catch.
> Renaming every symbol that currently has a name from this list to the
> corresponding name with a trailing underscore is an easily understood
> consistent change.
>
> 	That you would argue against is with things like "not breaking things" is a
> load of complete crap.
>
>> You want C++?  Fork the freely
>> available source code at a convenient point and convert it yourself.  As
>> long as it stays GPL, you're perfectly within your rights so to do.
>> Hobson's choice is yours.  Belaboring this point is silly.
>
> 	Making ridiculous arguments like that a consistent change of a small set of
> names is "breaking things in a stable kernel" is silly.
>
> 	And, FWIW, it isn't even necessary to change those names. That is only
> needed to compile the kernel in C++, which is not what anyone was talking
> about. Supporting C++ modules, for example, would work fine even if the
> kernel had variables called 'class' or 'private'. (Though things could be
> done a lot more cleanly if it didn't as it would require some remapping
> before and after compilation.)
>
> 	DS


You know. All one needs to do is to compile C++ module code outside
the kernel. I compile such code outside the kernel all the time.

You make make your own private header directory that contains the
few modified kernel headers that you need. You put this directory
first in the -I(SearchList) on the command-line so that the "bad"
kernel headers are never even found.

Then you make a kernel module with C++. Remember that you can't
include your C++ runtime library on stuff that runs inside the
kernel. I think that, just to access the "struct file" structure,
which is fairly important for modules, you are going to need
'C' wrappers around your C++ code. Once you get something to actually
load IFF you get it to load, you will probably find that most
of your code is wrappers, which don't disappear. They are essential
conversion procedures.

After a few days of capture the Stockholm syndrome person will probably
understand that C++ was not designed for operating system kernels.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
