Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263237AbUKAOLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263237AbUKAOLc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 09:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbUKAOLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:11:30 -0500
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:3968 "EHLO
	midnight.suse.cz") by vger.kernel.org with ESMTP id S263237AbUKAOHY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:07:24 -0500
Date: Mon, 1 Nov 2004 15:07:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: Map extra keys on compaq evo
Message-ID: <20041101140717.GA1180@ucw.cz>
References: <20041031213859.GA6742@elf.ucw.cz> <200410312016.08468.dtor_core@ameritech.net> <20041101080306.GA1002@elf.ucw.cz> <20041101093830.GA1145@ucw.cz> <20041101133214.GE32347@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101133214.GE32347@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 02:32:14PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > > Compaq Evo notebooks seem to use non-standard keycodes for their extra
> > > > > keys. I workaround that quirk with dmi hook.
> > > > > 
> > > > 
> > > > Why don't you just call "setkeycodes" from your init script?
> > > 
> > > In such case I'd need to configure keys at two different places, and
> > > that's ugly. I have to configure these extra keys with "hotkeys"
> > > anyway (input layer does not provide list of keys available, so
> > 
> > It does.
> 
> Really? I know input has ability to say that, but at least on arima
> notebook, evtest definitely prints keys that are not there...

It depends on whether you configure it exactly for your keyboard. In the
default config it's configured for a default keyboard, which includes
all at least a bit standardized keys.

>     Event code 128 (Stop)
>     Event code 140 (Calc)
>     Event code 142 (Sleep)
>     Event code 143 (WakeUp)
>     Event code 150 (WWW)
>     Event code 155 (Mail)
>     Event code 156 (Bookmarks)
>     Event code 157 (Computer)
>     Event code 158 (Back)
>     Event code 159 (Forward)
>     Event code 163 (NextSong)
>     Event code 164 (PlayPause)
>     Event code 165 (PreviousSong)
>     Event code 166 (StopCD)
>     Event code 173 (Refresh)
> ...
> 
> With accurate list "hotkeys" could run with no configuration, but I am
> afraid maintaining accurate list of keys for each keyboard is way too
> much work.

The lists need to be kept _somewhere_, so why not have a userspace
database with a program that loads the description into the kernel at
boot, possibly using DMI as a hint to what keyboard is connected?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
