Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWCQPka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWCQPka (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 10:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbWCQPka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 10:40:30 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:64519 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932738AbWCQPk3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 10:40:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <Pine.LNX.4.61.0603171527090.24878@yvahk01.tjqt.qr>
x-originalarrivaltime: 17 Mar 2006 15:40:12.0745 (UTC) FILETIME=[14824390:01C649D9]
Content-class: urn:content-classes:message
Subject: Re: /dev/stderr gets unlinked 8]
Date: Fri, 17 Mar 2006 10:40:11 -0500
Message-ID: <Pine.LNX.4.61.0603171029340.8333@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /dev/stderr gets unlinked 8]
Thread-Index: AcZJ2RSLXTwLmRLuTnW8oU3I3wFkEA==
References: <200603141213.00077.vda@ilport.com.ua> <jehd5zq28o.fsf@sykes.suse.de> <Pine.LNX.4.61.0603162111400.11776@yvahk01.tjqt.qr> <200603170834.27694.vda@ilport.com.ua> <Pine.LNX.4.61.0603171527090.24878@yvahk01.tjqt.qr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: "Denis Vlasenko" <vda@ilport.com.ua>, "Andreas Schwab" <schwab@suse.de>,
       "Stefan Seyfried" <seife@suse.de>, <linux-kernel@vger.kernel.org>,
       <christiand59@web.de>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Mar 2006, Jan Engelhardt wrote:

>>>>> any good daemon closes stdout, stderr, stdin
>>>>
>>>> A real good daemon would redirect them to /dev/null.
>>>
>>> and writes to /var/log/mysql/...
>>
>> And has log rotation. Apache has log rotation. Squid has log rotation.
>>
>> Why they all need to have log rotation code? I forced them all to just
>
> I dunno. SUSE Linux (no advertisement intended) uses a global solution -
> "logrotate" rather than using each project's own logrotation.
>
>> write log to stderr, and multilog from daemontools does the logging
>> (with rotation and postprocessing (for example, feeds Squid log into
>> Mysql db)) just fine.
>>
>> But we digress. Is there any magic (mount --bind?) to make
>> /dev/stderr undestructible?
>
> If not, you could write an LSM that prohibits unlinking /dev/stderr.
>
> Jan Engelhardt

That symlink isn't even used -- at least by any sane program!
I don't have a clue why these things were created and what they
were for. The objects stdin, stdout, and stderr, are 'C' runtime
library pointers to opaque types associated with the file descriptors,
STDIN_FILENO, STDOUT_FILENO, and STDERR_FILENO. The presence of
these bogus sym-links in /dev represent some kind of obfuscation
and have no value except to confuse (or identify a RedHat distribution).


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
