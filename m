Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbTDPBh5 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 21:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264190AbTDPBh5 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 21:37:57 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:35593
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S264189AbTDPBh4 
	(for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 21:37:56 -0400
Subject: Re: SoundBlaster Live! with kernel 2.5.x
From: Robert Love <rml@tech9.net>
To: Udo Hoerhold <maillists@goodontoast.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304152001.35975.maillists@goodontoast.com>
References: <200304152001.35975.maillists@goodontoast.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050457791.3664.188.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 15 Apr 2003 21:49:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-15 at 20:01, Udo Hoerhold wrote:

> I've been running Debian woody with 2.4.20 kernel.  I'm trying to switch to 
> 2.5.  I built 2.5.67 with emu10k driver in the kernel (same as I had with 
> 2.4.20), but I get only a lot of popping sounds from the sound card.  I also 
> tried 2.5.50 and 2.5.67-mm3, with the same result.  I googled for emu10k and 
> soundblaster with 2.5, but I haven't seen anyone else with the same problem.  
> Does anyone know what this problem is?

Not sure.  It seems to work fine here.

Are you using ALSA or OSS?  Best bet is ALSA.  You want something like:
        
        CONFIG_SND=y
        CONFIG_SND_SEQUENCER=y
        CONFIG_SND_OSSEMUL=y
        CONFIG_SND_MIXER_OSS=y
        CONFIG_SND_PCM_OSS=y
        CONFIG_SND_SEQUENCER_OSS=y
        CONFIG_SND_EMU10K1=y

And then do not include any of the OSS stuff.

Then a normal audio playback on /dev/audio or whatever should work fine.

If not, do you see any errors during boot?

	Robert Love


