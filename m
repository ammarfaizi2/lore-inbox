Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRB0Mi2>; Tue, 27 Feb 2001 07:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRB0MiS>; Tue, 27 Feb 2001 07:38:18 -0500
Received: from [138.6.98.137] ([138.6.98.137]:40710 "EHLO
	caspian.prebus.uppsala.se") by vger.kernel.org with ESMTP
	id <S129112AbRB0MiL>; Tue, 27 Feb 2001 07:38:11 -0500
Message-ID: <E44E649C7AA1D311B16D0008C73304460933AF@caspian.prebus.uppsala.se>
From: Per Erik Stendahl <PerErik@onedial.se>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Bug in cdrom_ioctl?
Date: Tue, 27 Feb 2001 13:34:41 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

In linux-2.4.2/drivers/cdrom/cdrom.c:cdrom_ioctl() branches
CDROM_SET_OPTIONS and CDROM_CLEAR_OPTIONS both return like this:

    return cdi->options;

If cdi->options is non-zero, the ioctl() calls returns non-zero.
My ioctl(2) manpage says that a successful ioctl() should return
zero. Now I dont know which is at fault here - the cdrom.c code or
the manpage. :-) Could somebody enlighten me?

/Per Erik Stendahl
