Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280211AbRKEEqZ>; Sun, 4 Nov 2001 23:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280207AbRKEEqP>; Sun, 4 Nov 2001 23:46:15 -0500
Received: from maila.telia.com ([194.22.194.231]:31959 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S280212AbRKEEqA>;
	Sun, 4 Nov 2001 23:46:00 -0500
Message-Id: <200111050445.fA54jto23310@maila.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Timur Tabi <ttabi@interactivesi.com>
Subject: [file interface] Re: Module Licensing?
Date: Mon, 5 Nov 2001 05:40:18 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01102920463500.03524@newton.cevio.com> <3BDE3360.80731876@mcn.net> <3BDEE301.3000008@interactivesi.com>
In-Reply-To: <3BDEE301.3000008@interactivesi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 October 2001 18:27, Timur Tabi wrote:
> TimO wrote:
> > Ugghh!  Don't confuse/equate MODULE_LICENSE with EXPORT_SYMBOL_GPL_ONLY;
> > two different animals, two differnet goals.  See archives for more info.
>
> What happens is a module is distributed as a combination of open-source .c
> files and closed-source .o files.  That is, it's "mixed source" - part of
> the driver is open-source and part is closed-source.  What happens if the
> open-source version of the driver is the only code that uses GPL-only
> symbols. How is that handled?
>

This is the approach I would use:

Kernel module:
 Exports a standard interface like file or terminal (or several...)
 GPL all of this work.
 Make it useful for others too - and you may sell some additional HW.

Propritary code (user application):
 Uses standard file operations - like fopen, seek, ...
 The needed headers are LGPL and thus safe.

Comments?


/RogerL 
-- 
Roger Larsson
Skellefteå
Sweden
