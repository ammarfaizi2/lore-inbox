Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbUKANc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUKANc0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 08:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbUKANcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 08:32:25 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20933 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262270AbUKANcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:32:15 -0500
Date: Mon, 1 Nov 2004 14:32:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: Map extra keys on compaq evo
Message-ID: <20041101133214.GE32347@atrey.karlin.mff.cuni.cz>
References: <20041031213859.GA6742@elf.ucw.cz> <200410312016.08468.dtor_core@ameritech.net> <20041101080306.GA1002@elf.ucw.cz> <20041101093830.GA1145@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101093830.GA1145@ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Compaq Evo notebooks seem to use non-standard keycodes for their extra
> > > > keys. I workaround that quirk with dmi hook.
> > > > 
> > > 
> > > Why don't you just call "setkeycodes" from your init script?
> > 
> > In such case I'd need to configure keys at two different places, and
> > that's ugly. I have to configure these extra keys with "hotkeys"
> > anyway (input layer does not provide list of keys available, so
> 
> It does.

Really? I know input has ability to say that, but at least on arima
notebook, evtest definitely prints keys that are not there...

...
    Event code 128 (Stop)
    Event code 140 (Calc)
    Event code 142 (Sleep)
    Event code 143 (WakeUp)
    Event code 150 (WWW)
    Event code 155 (Mail)
    Event code 156 (Bookmarks)
    Event code 157 (Computer)
    Event code 158 (Back)
    Event code 159 (Forward)
    Event code 163 (NextSong)
    Event code 164 (PlayPause)
    Event code 165 (PreviousSong)
    Event code 166 (StopCD)
    Event code 173 (Refresh)
...

With accurate list "hotkeys" could run with no configuration, but I am
afraid maintaining accurate list of keys for each keyboard is way too
much work.
								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
