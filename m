Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129543AbQLMWyS>; Wed, 13 Dec 2000 17:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130522AbQLMWyI>; Wed, 13 Dec 2000 17:54:08 -0500
Received: from [209.143.110.29] ([209.143.110.29]:34055 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S129543AbQLMWxs>; Wed, 13 Dec 2000 17:53:48 -0500
Message-ID: <3A37F6BF.5ABAAE95@the-rileys.net>
Date: Wed, 13 Dec 2000 17:22:55 -0500
From: David Riley <oscar@the-rileys.net>
Organization: The Riley Family
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jakma <paul@clubi.ie>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via82cxxx_audio - bad latency
In-Reply-To: <Pine.LNX.4.30.0012130244140.1326-100000@fogarty.jakma.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma wrote:
> 
> hi,
> 
> i think somethings gone wrong with via82cxxx_audio. Playing anything
> through it seems to cause massive latency in apps like xmms, esd,
> asmixer, etc.. anything to do with playing or mixer levels suddenly
> takes a minute or more to respond.
> 
> It didn't always do this, and when it started happening i assumed it
> was either something bad in esd or xmms (which i tend to upgrade a
> lot). However it still happens when esd is disabled. eg, i use mpg123
> to play an mp3 file, and asmixer doesn't change the volume till a
> minute or two after i moused it.
> 
> if i SIGSTOP mpg123, asmixer immediately becomes responsive again and
> implements the pending volume change, as soon i SIGCONT mpg123,
> asmixer becomes very unresponsive again.
> 
> same thing with esd, if i STOP mpg123, other apps like esd and
> non-esd mixers become responsive, soon as i start playing again they
> go unresponsive.
> 
> same thing with playing from esd applications, everything inlcuding
> the playing app itself (eg xmms) is unresponsive, if i STOP it, the
> mixers instantly become responsive, soon as i CONT the playing app
> everything is "dead" again.
> 
> kernel is test12-final. AMD K7, Asus K7M board
> 
> the via is sharing an interrupt, though normally the buslogic is not
> being used. (the interrupt sharing has been there a lot longer than
> this problem)

I ran into the same problems with the same driver.  Sharing an interrupt
isn't the problem, it's just a really young driver.  The ALSA driver
works fine, but I switched to an Ensoniq/Creative PCI card because I
found that the chipset just clipped like mad anyway (just cheapness, I
suppose, or maybe I'm doing something wrong) when mixing sounds together
(as in Quake3 or esd).  If you want to use it, though, I'd suggest using
ALSA.  It works.  Alternatively, you could fix the OSS driver.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
