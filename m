Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310994AbSCHSMz>; Fri, 8 Mar 2002 13:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310996AbSCHSMt>; Fri, 8 Mar 2002 13:12:49 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:51469 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S310995AbSCHSMb>; Fri, 8 Mar 2002 13:12:31 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76E6@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Russell King'" <rmk@arm.linux.org.uk>
Cc: "'Bill Nottingham'" <notting@redhat.com>,
        "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: [PATCH] serial.c procfs kudzu - discussion
Date: Fri, 8 Mar 2002 10:12:30 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Mar 08, 2002, Russell King wrote:
> 
> I think there are two bugs here that need treating in different ways.
> 
> 1. Not displaying port statistics for iomem-based ports.  This is
>    probably an oversight when iomem ports were added to the serial
>    driver.
> 
> 2. "port:" entry being 0.  I don't think we really want to report IO
>    port or memory addresses here without giving userspace some
>    indication which we're reporting.
> 
> For 2, I'd suggest replacing "port:" with "mem:" for iomem ports, and
> changing the serinfo: line to reflect the changed format (this is
> probably ignored by kudzu though.)
> 
> Does this sound reasonable?

Hi Russell,

Yes. I'll change the serinfo line rev marking from 1.0 to 1.1 and label 
the  iomem value as "mem". If I remember correctly, kudzu detects that 
field by its delimiters, so it does not matter that we change the field 
label. It's probably easiest for me to verify by just trying it. If there 
is a surprise there, I will inform Bill Nottingham at Red Hat. 

Also, I'll verify that the port statistics flow unit runs for the iomem 
case.

Thanks,
Ed Vance
