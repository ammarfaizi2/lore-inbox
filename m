Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTIOLjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 07:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTIOLjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 07:39:49 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:44299 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S261294AbTIOLjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 07:39:47 -0400
Date: Mon, 15 Sep 2003 13:39:43 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-t4/5] Error inserting module snd
In-Reply-To: <3F65A230.3020806@gts.it>
Message-ID: <Pine.LNX.4.44.0309151335490.10449-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefano!

On Mon, 15 Sep 2003, Stefano Rivoir wrote:

> Hi all
> 
> When inserting module snd, modprobe bails out saying
> 
> snd: Unknown parameter 'device_mode'
> 
> The result is that the sound is completely unavailable. This happens 
> with -test4 and -test5 (and -test5-mm2), but it was OK up to -test3,
> IIRC.
> 
This is a configuration error: check modprobe.conf for the options for snd and 
remove the 'device_mode' part. Looks like the debian alsa stuff has this small 
incompatibility with the 0.9.6 kernel modules. BTW, I had the problem with 
-test3 already.

I am by no means an ALSA expert, but this solved the problem for me.

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |  Telefax 089/289-12570  |
+---------------------------+-------------------------+

