Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUD3CYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUD3CYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 22:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUD3CYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 22:24:39 -0400
Received: from 200-170-96-180.veloxmail.com.br ([200.170.96.180]:28089 "HELO
	qmail-out.velox.com.br") by vger.kernel.org with SMTP
	id S265040AbUD3CY3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 22:24:29 -0400
Date: Wed, 28 Apr 2004 18:11:27 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: Burton Windle <bwindle@fint.org>
Subject: Re: TCP: Hash tables configured
In-Reply-To: <Pine.LNX.4.58.0404281702040.931@morpheus>
Message-ID: <Pine.LNX.4.58.0404281805010.881@pervalidus.dyndns.org>
References: <Pine.LNX.4.58.0404281657360.881@pervalidus.dyndns.org>
 <Pine.LNX.4.58.0404281702040.931@morpheus>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Burton Windle wrote:

> Odd... maybe related to amount of ram perhaps?

I don't think so. It's on the same machine with 2x256Mb. The
only change is the compiler, as is the only "change" in dmesg.

But it doesn't look like the compiler, as Google returned some
"TCP: Hash tables configured (established 32768 bind 65536)"
for 2.95.x and "TCP: Hash tables configured (established 32768
bind 32768)" for 3.x.

> bwindle@morpheus:~$ dmesg | grep Hash
> TCP: Hash tables configured (established 16384 bind 4681)
> bwindle@morpheus:~$ cat /proc/version
> Linux version 2.6.5 (root@morpheus) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 Mon Apr 5 14:43:44 EDT 2004
>
> bwindle@balrog:~$ dmesg | grep Hash
> TCP: Hash tables configured (established 131072 bind 65536)
> bwindle@balrog:~$ cat /proc/version
> Linux version 2.6.5 (root@debian) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Tue Apr 27 09:34:17 EDT 2004
>
> bwindle@dual266:~$ dmesg | grep Hash
> TCP: Hash tables configured (established 8192 bind 8192)
> bwindle@dual266:~$ cat /proc/version
> Linux version 2.6.6-rc2-bk1 (root@dual266) (gcc version 2.95.4 20011002 (Debian prerelease)) #18 SMP Fri Apr 23 10:15:53 EDT 2004
>
>
>
> --
> Burton Windle                           bwindle@fint.org
>
>
> On Wed, 28 Apr 2004, [ISO-8859-1] Frédéric L. W. Meunier wrote:
>
> > If I compile 2.4.x or 2.6.x with GCC 2.95.4 I see
> >
> > TCP: Hash tables configured (established 32768 bind 32768)
> >
> > If I instead use 3.3.3, I see
> >
> > TCP: Hash tables configured (established 32768 bind 65536)
> >
> > Is this expected ?

-- 
http://www.pervalidus.net/contact.html
