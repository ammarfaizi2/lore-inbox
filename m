Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030557AbWCTWFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030557AbWCTWFE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030555AbWCTWEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:04:31 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:7172 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030541AbWCTWEV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:04:21 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <jed5ggx39x.fsf@sykes.suse.de>
x-originalarrivaltime: 20 Mar 2006 22:04:13.0120 (UTC) FILETIME=[38E1BC00:01C64C6A]
Content-class: urn:content-classes:message
Subject: Re: lstat returns bogus values.
Date: Mon, 20 Mar 2006 17:04:12 -0500
Message-ID: <Pine.LNX.4.61.0603201655370.25162@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: lstat returns bogus values.
Thread-Index: AcZMajjoub6QtNFATgurkU/9pNAy5A==
References: <Pine.LNX.4.61.0603201312320.23345@chaos.analogic.com> <jed5ggx39x.fsf@sykes.suse.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Andreas Schwab" <schwab@suse.de>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Mar 2006, Andreas Schwab wrote:

> "linux-os (Dick Johnson)" <linux-os@analogic.com> writes:
>
>> The "kernelly-corrected" stuff should have been returned by lstat()
>
> What should lstat return for a cdrom device node that has no medium?
> Should "ls -l /dev/cdrom" block until you have inserted a CD?
>
> Andreas.
>

`ls` only means something when there is a file-system so `ls`
is not appropriate until you have a file-system. Currently
`ls` on such a block device correctly returns the device type.

I think lstat should return -1 and the appropriate error code
should be in errno (perhaps ENOMEDIUM).


> --
> Andreas Schwab, SuSE Labs, schwab@suse.de
> SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
> PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.48 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
