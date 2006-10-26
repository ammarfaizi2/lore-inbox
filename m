Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423621AbWJZROz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423621AbWJZROz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 13:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423623AbWJZROz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 13:14:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36268 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1423621AbWJZROy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 13:14:54 -0400
Date: Thu, 26 Oct 2006 13:14:53 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: UCB1400 driver problem in pxa270
In-reply-to: <9975050.1161880631044.JavaMail.websites@opensubscriber>
X-X-Sender: nico@xanadu.home
To: saravanan_sprt@hotmail.com
Cc: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0610261310100.12418@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <9975050.1161880631044.JavaMail.websites@opensubscriber>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006, saravanan_sprt@hotmail.com wrote:

> Hi all,
> 
> I am a newbie in using UCB1400 chip. Iam using Toradex Colibri module PXA270 as my target system with UCB1400 chip integrated.
> I have a problem in enabling the audio system using UCB1400. Can anyone point me, how could I enable and use the UCB1400 driver on linux 2.6.12 platform. I have applied Nicolas Pitre patches and configured kernel CONFIG_INPUT, CONFIG_SND, CONFIG_SOUND,CONFIG_SND_PXA2xx_AC97, CONFIG_SND_PXA2xx_PCM to  =y. The kernel builds well, but on boot the UCB1400 driver didn't gets registered and there are no more interrupts enabled in /proc/interrupts with following boot message,
> .....
> .....
> ts: UCB1x00 touchscreen protocol output
> Advanced Linux Sound Architecture Driver Version 1.0.9rc2 ( The MAr 24 10:34:34 2005 UTC)
> ALSA device list:
>   No soundcards found.
> ....
> ....
> 
> The problem seems to be due to driver_register(pxa2xx-ac97) and bus match.
> 
> Any help will be appreciated .

Look in arch/arm/mach-pxa/mainstone.c for mst_audio_device.  This is an 
example of the  platform_device structure the pxa2xx-ac97 driver is 
looking for.


Nicolas
