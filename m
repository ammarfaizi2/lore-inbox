Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTJPLSX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 07:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbTJPLSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 07:18:23 -0400
Received: from mail.gmx.de ([213.165.64.20]:24206 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262850AbTJPLSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 07:18:21 -0400
Date: Thu, 16 Oct 2003 13:18:20 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: wind@cocodriloo.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <3F8E757A.5010008@pobox.com>
Subject: Re: [BUG] [2.4.21] 8139too 'too much work at interrupt'...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <26145.1066303100@www7.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Yes, the 8139too driver is doing it's job correctly - I was just thinking
about the source of the starvation, ie the cause of the effect. I.e. the
brokeness is elsewhere, in other drivers etc.

Dan

> Daniel Blueman wrote:
> > I have seen problems like this when a bad driver was spending loads of
> time
> > in it's SA_INTERRUPT (ie meant to be 'fast') IRQ handler ...this
> buffered up
> > *lots * of packets to be handled, and caused this message.
> > 
> > Perhaps we should profile?
> 
> 
> There is no need to profile, I described the problem precisely.
> 
> 	Jeff
> 
> 
> 

-- 
Daniel J Blueman

NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

