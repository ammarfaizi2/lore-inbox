Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032133AbWLGM2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032133AbWLGM2G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032136AbWLGM2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:28:06 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:1562 "EHLO
	odyssey.analogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032133AbWLGM2C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:28:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 07 Dec 2006 12:27:59.0078 (UTC) FILETIME=[21601860:01C719FB]
Content-class: urn:content-classes:message
Subject: Re: Detecting I/O error and Halting System  : come back
Date: Thu, 7 Dec 2006 07:27:58 -0500
Message-ID: <Pine.LNX.4.61.0612070713380.16015@chaos.analogic.com>
In-Reply-To: <20061207110104.74408.qmail@web27706.mail.ukl.yahoo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Detecting I/O error and Halting System  : come back
thread-index: AccZ+yGDSsJo1nrMQHutj4XfADA19g==
References: <20061207110104.74408.qmail@web27706.mail.ukl.yahoo.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "zine el abidine Hamid" <zine46@yahoo.fr>
Cc: <gene.heskett@verizon.net>, "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Dec 2006, zine el abidine Hamid wrote:

> Hi evrybody,
>
> I come back with my problem of "I/O error" (refer to
> the following link to reffresh your mind :
> http://groups.google.fr/group/linux.kernel/browse_thread/thread/386b69ca8389cda0/a58d753bf87c4f06?lnk=st&q=hamid+ZINE+EL+ABIDINE&rnum=2&hl=fr#a58d753bf87c4f06
> )

Please don't copy everybody in the universe when you have a problem. That said, 
it is likely that you have a bad spot on your hard disk. You can verify this
bu copying the RAW device to the null device and checking for errors. Assume 
that your hard disk device was /dev/hda (not /dev/hda1 or other partitions).
You would simply execute from the root account, cp `/dev/hda /dev/null`.
That will read every block on your hard disk. If that does not produce any 
errors, then the problem that you have is caused by file-system errors,
not device errors.

To fix file-system errors, you need to restart in single-user mode:
`init 1` should bring you to that mode, then you need to unmount the 
file-systems and execute fsck on each of them. If you are unable to unmount
the file systems, then you need to cold boot in single-user mode to do so.

If you have bad blocks then you need to execute `badblocks` with its output
to `fsck -l`. That will map the bad blocks away from the file-system.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.68 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
