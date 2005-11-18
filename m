Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbVKRL0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbVKRL0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 06:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbVKRL0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 06:26:54 -0500
Received: from mailrelay2.lrz-muenchen.de ([129.187.254.102]:14787 "EHLO
	mailrelay2.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id S1161063AbVKRL0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 06:26:53 -0500
From: Bernd Donner <bdonner@physik.tu-muenchen.de>
Organization: TU =?iso-8859-1?q?M=FCnchen?=
To: linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Date: Fri, 18 Nov 2005 14:46:47 +0100
User-Agent: KMail/1.8.2
References: <87zmoa0yv5.fsf@obelix.mork.no> <d120d5000511171357g4d7a8d54hcc1c1d1cffa8856e@mail.gmail.com>
In-Reply-To: <d120d5000511171357g4d7a8d54hcc1c1d1cffa8856e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511181446.48044.bdonner@physik.tu-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 November 2005 22:57, Dmitry Torokhov wrote:
> Crazy idea - did you let it finish booting or you hit suspend as soon
> as you could? It looks like kseriod was busy discovering your
> touchpad/trackpoint for the first time...

I did let it finish booting. Since the resume failed, i patiently waited for 
fsck and X startup to finish.

> Anyway, Pavel, I think 6 seconds it too short of a timeout for
> stopping all tasks. PS/2 is pretty slow, trackpad reset can take up to
> 2 seconds alone...
>
> Bjorn, does it help if you change TIMEOUT in kernel/power/process.c to 30 *
> HZ?

Increasing the TIMEOUT to 30 seconds on an 2.6.14 kernel does solve the 
reported problem for me. The resume now succeeds.

Thanks
Bernd
