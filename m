Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWAOU6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWAOU6r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWAOU6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:58:47 -0500
Received: from flock1.newmail.ru ([212.48.140.157]:41965 "HELO
	flock1.newmail.ru") by vger.kernel.org with SMTP id S1750864AbWAOU6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:58:46 -0500
From: Andrey Borzenkov <arvidjaar@newmail.ru>
To: Rudolf Marek <r.marek@sh.cvut.cz>
Subject: Re: [lm-sensors] 2.6.15: lm90 0-004c: Register 0x13 read failed (-1)
Date: Sun, 15 Jan 2006 23:58:34 +0300
User-Agent: KMail/1.9.1
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
References: <200601142223.35838.arvidjaar@newmail.ru> <200601152248.07800.arvidjaar@newmail.ru> <43CAB1B7.6020903@sh.cvut.cz>
In-Reply-To: <43CAB1B7.6020903@sh.cvut.cz>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601152358.38095.arvidjaar@newmail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 15 January 2006 23:33, Rudolf Marek wrote:
>
> Well it seems this ali 15x3 has maybe same hardware bug? It was mentioned
> already here: http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=2030
>
> > In the log below you can see that the ALI15X3 chip seems to keep in
> > idle-state without reporting "done", but it does not turn in "busy"
> > state. I patched the driver to do the reset procedure (with
> > ALI15X3_T_OUT) after the error, but afterwards, the chip turns to "busy"
> > state until next reboot.
>

This is already done in i2c-ali1535 in current kernel. So it looks like HW 
issue that can be ignored at best. After reset SMBus continues to work. The 
only question is, should we provide an option to shut up those errors; 
assuming user knows (s)he has buggy controller there is no reason to spam 
dmesg with known issue. Will patch be accepted? I will emit first occurence 
of this error to let users know something is fishy and supress further ones. 
But this has to wait for next week, it is already too late here.

Thank you for information

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDyrd9R6LMutpd94wRAuNVAKCwq+yTwvFt6jYLS1wL5pIDr68IMwCbBHb+
yXAnHp+jzVFW1ddKVbZVkY8=
=ABky
-----END PGP SIGNATURE-----
