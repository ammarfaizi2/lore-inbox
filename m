Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268266AbTBMT3k>; Thu, 13 Feb 2003 14:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268279AbTBMT3k>; Thu, 13 Feb 2003 14:29:40 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26243
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268266AbTBMT3j>; Thu, 13 Feb 2003 14:29:39 -0500
Subject: Re: via8235 Audio on 2.4.21-pre
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jonathan Thorpe <wd.dev@verizon.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030213221802.09cd1afb.wd.dev@verizon.net>
References: <20030213221802.09cd1afb.wd.dev@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045168806.6493.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 13 Feb 2003 20:40:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-13 at 11:18, Jonathan Thorpe wrote:
> work quite nicely. Recent updates have allowed the majority of
> applications to work, however any version of ESD fails (whilst the same
> configuration works fine with other sound drivers).

esd is the one failure case I know about

> This has been a problem ever since the first via82cxxx_audio releases with
> vt8235 support, but at present, I'm using 2.4.21-pre4-ac4. When ESD is
> loaded, 3 of the five beeps are heard (unless the beeps are disabled, in
> which I can get about 0.25 seconds of audio to play through ESound) and
> then ESound will hang. Once esound is killed, I get the message:
> 
> via_audio: ignoring drain playback error -512

The printk itself is actually a bug, but its providing clues. Something
esd does seems to stop the audio engine running. You get one chunk then
it all stops. I can duplicate it here too.

Alan
