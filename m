Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285096AbRLFKUZ>; Thu, 6 Dec 2001 05:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285098AbRLFKUP>; Thu, 6 Dec 2001 05:20:15 -0500
Received: from [195.63.194.11] ([195.63.194.11]:49928 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S285096AbRLFKUB>; Thu, 6 Dec 2001 05:20:01 -0500
Message-ID: <3C0F43D7.87B3948@evision-ventures.com>
Date: Thu, 06 Dec 2001 11:09:27 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
In-Reply-To: <Pine.LNX.4.30.0112051924560.3073-100000@mustard.heime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> > I suspect the per-device readahead for IDE is limiting the
> > effect of vm_max_readahead ...
> 
> hm...
> 
> any way to avoid this? I mean... The readahead in vm is layered above the
> actual device, and should therefore not be limited... Am I right? You
> could do several device calls, and fake readahead, and probably get pretty
> much out of it.

He means the hardware device read ahead, which can be changed by using
hdparm -a 32 -A1 /dev/hda
for example.
The value of the read ahead one layer on top of it
(read_ahead array) can't have *any* impact on performance.
