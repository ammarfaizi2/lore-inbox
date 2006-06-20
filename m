Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbWFTLPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWFTLPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWFTLPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:15:21 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:34824 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932598AbWFTLPU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:15:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 20 Jun 2006 11:15:18.0820 (UTC) FILETIME=[D03C0640:01C6945A]
Content-class: urn:content-classes:message
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Date: Tue, 20 Jun 2006 07:15:16 -0400
Message-ID: <Pine.LNX.4.61.0606200710090.7695@chaos.analogic.com>
In-Reply-To: <20060619220359.GA6218@bouh.residence.ens-lyon.fr>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: emergency or init=/bin/sh mode and terminal signals
thread-index: AcaUWtBDIwEQ0zzvTlSOzzc27Red/Q==
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr> <20060618213342.GG13255@w.ods.org> <20060619220359.GA6218@bouh.residence.ens-lyon.fr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Samuel Thibault" <samuel.thibault@ens-lyon.org>
Cc: "Willy Tarreau" <w@1wt.eu>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Jun 2006, Samuel Thibault wrote:

> Hi,
>
> Willy Tarreau, le Sun 18 Jun 2006 23:33:42 +0200, a écrit :
>> I too am used to starting with init=/bin/sh, but I'm also used to launch
>> ping in the background. However, if getting Ctrl-C working implies a risk
>> of killing init, then I'd rather keep it the old way.
>
> Maybe you should rather use init=/bin/login . If your login program is
> smart enough, it will set a session and thus ^C will work.
>
> Samuel
> -

Actually, a rather trivial program can be written, the name of
which you define as init on the command-line 'init=/bin/myprog'.
This program sets up the controlling terminal, then exec()s
/bin/bash or whatever shell you want. Since it's exec()ed, the
PID remains at 1 so after you have fixed whatever you needed
to fix, you can execute `exec /sbin/init auto` and continue
with a normal startup. This is certainly cleaner than poking
holes in the kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
