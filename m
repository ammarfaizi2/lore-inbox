Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269621AbUJGBak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbUJGBak (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 21:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269617AbUJGBaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 21:30:39 -0400
Received: from inetc.connecttech.com ([64.7.140.42]:54799 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S269603AbUJGBa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 21:30:28 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Samuel Thibault'" <samuel.thibault@ens-lyon.org>
Cc: "=?iso-8859-1?Q?'S=E9bastien_Hinderer'?=" 
	<Sebastien.Hinderer@libertysurf.fr>,
       <rmk@arm.linux.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch] new serial flow control
Date: Wed, 6 Oct 2004 21:30:04 -0400
Organization: Connect Tech Inc.
Message-ID: <043c01c4ac0d$2c8bac80$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <1097069353.29251.4.camel@localhost.localdomain>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox
> On Mer, 2004-10-06 at 08:38, Samuel Thibault wrote:
> > No: CRTSCTS is a one-signal-for-each-way flow control: each
> > side of the link tells whether it can receive data. CTVB is a
> > two-signals-for-only-one-way flow control: the device tells when it
> > wants to send data, the PC acknowledges that, and then one frame of
> > data can pass.
> 
> This sounds a lot like RS485 and some other related stuff. I need to
> poke my pet async guru and find out if they are the same thing. If so
> that would be useful.

RS485 is a driver-transparent electrical interface. Unfortunately the
half-duplex and master-slave(s) arrangements require some sort of
token passing to know when they can successfully transmit. This is
usually handled by the apps in some manner, although it's often wanted
to be handled by the serial driver. This could be one method of
signalling, but isn't sufficient to show RS485 operation.

I haven't seen this style of flow control before. What uses it?

..Stu

