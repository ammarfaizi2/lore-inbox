Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270750AbTG0LrR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 07:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270751AbTG0LrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 07:47:17 -0400
Received: from lidskialf.net ([62.3.233.115]:30919 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S270750AbTG0LrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 07:47:16 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Rahul Karnik <rahul@genebrew.com>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
Date: Sun, 27 Jul 2003 13:02:30 +0100
User-Agent: KMail/1.5.2
Cc: Marcelo Penna Guerra <eu@marcelopenna.org>,
       lkml <linux-kernel@vger.kernel.org>, Laurens <masterpe@xs4all.nl>,
       Jeff Garzik <jgarzik@pobox.com>
References: <200307262309.20074.adq_dvb@lidskialf.net> <200307271222.13649.adq_dvb@lidskialf.net> <3F23BC1D.7070804@genebrew.com>
In-Reply-To: <3F23BC1D.7070804@genebrew.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307271301.41660.adq_dvb@lidskialf.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 July 2003 12:48, Rahul Karnik wrote:
> Andrew de Quincey wrote:
> > Ah, so THATS who they licensed it from. I didn't think nividia would go
> > to the bother of designing their own ethernet hardware.
>
> Actually, this is not certain, but it is one of the guesses. So far,
> Nforce2 = AMD IDE + Intel sound + <unknown> ethernet.

Hmm, the MAC address is in a different place on the nvidia hardware.

I've just dumped the mmapped IO space on mine. The MAC address shows up at 
offset 0xa8, but the amd8111e driver is looking for it at 0x160 (there's just 
loads of 0x00 there).

