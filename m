Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbTGCWXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbTGCWXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:23:46 -0400
Received: from front2.netvisao.pt ([213.228.128.57]:28876 "HELO
	front2.netvisao.pt") by vger.kernel.org with SMTP id S265422AbTGCWXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:23:44 -0400
Message-ID: <003d01c341b3$aa4c89c0$cc3a81d9@netvisao.pt>
From: "NunO fELICIO" <nmpf@netvisao.pt>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.40.0307031759060.10456-100000@domesticus.fery-local.hu>
Subject: Re: Geode GX1, video acceleration -> crash
Date: Thu, 3 Jul 2003 23:37:18 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, i have some troubles with that, do not use the fb driver from national,
look at http://www.directfb.org/ , they have very good drivers =).


Nuno Felicio
---------------------
Systems and Coca Cola

----- Original Message -----
From: "Ferenc Engard" <ferenc@engard.hu>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, July 03, 2003 5:24 PM
Subject: Geode GX1, video acceleration -> crash


> Hello there,
>
> First of all, I am new to the framebuffer business, and looks like
> that the linux-fbdev.org site is down. Where can I find a mailing list
> or other information resource about framebuffers in general, and about
> Geode hardware specifically? It is a nightmare to find any information
> for Geode on linux... :((
>
> I am developing a graphical app for an Advantech PCM-5820 (I think :),
> i.e. a Geode GX1 / CS5530 board, 64MB RAM, which I want to run a linux
> / framebuffer application on.
>
> Now, about my problem:
>
> I have installed the 2.4.17 kernel, patched with NSC's original Geode
> fb driver (nsc-kfb-driver-2.7.7.tar.gz), and compiled it successfully.
> Also, as I couldn't find in other places, I have downloaded the
> nsc_xfree_2.7.6.tgz package just to compile the GAL library
> (nsc_galfns.c) in it, as this was what I needed.
>
> First surprise: I cannot switch into 32bpp modes! Did I miss
> something? fbset refuses it, setting at boot time do not work either.
>
> Next, I have written a small application to test the processor's
> bitblt capability. The program calls Gal_screen_to_screen_blt() to
> scroll a rectangle on the screen, then usleeps a bit. It does work,
> although the scheduler do not give back the run to the task until
> approx. 20ms elapses (no problem at now), and in 16bpp, it do not
> scroll the region but inverses it(?!).  I suppose that it is not good
> that the console writes out things while the bitblt engine works.
> Question: should I disable writing to the console while my app runs?
> How?
>
> But the real problem is, that I wanted to benchmark the system while
> the scrolling continues, and issued a
> dd if=/dev/mem of=/dev/null bs=1024 count=32768
> command. For the second go, the system freezed like a good
> refrigerator. No kernel panic, nothing, just freezed. It can be
> repeated, if I copy just the 1st MB of RAM, then it freezes for the
> 5-6th go. :((
>
> What can I do? How to debug?
>
> Please cc your answers to ferenc@engard.hu, too!
>
> Thank you:
> Circum
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

