Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262938AbSJGI7F>; Mon, 7 Oct 2002 04:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262939AbSJGI7F>; Mon, 7 Oct 2002 04:59:05 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:35498 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262938AbSJGI7D>;
	Mon, 7 Oct 2002 04:59:03 -0400
Date: Mon, 7 Oct 2002 11:04:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.40 (-ac3) and 2.4.19-ck5: mousedev interfere with parport ;-(
Message-ID: <20021007110439.D63229@ucw.cz>
References: <200210060129.41010.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210060129.41010.Dieter.Nuetzel@hamburg.de>; from Dieter.Nuetzel@hamburg.de on Sun, Oct 06, 2002 at 01:29:40AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 01:29:40AM +0200, Dieter N?tzel wrote:
> While printing with latest hpijs-1.2.2-rss.1 (patched for older HP9xx 
> printers) at 1200x1200 DPI on 2.5.40-ac3 I found critical bug in the 
> "mousedev" module.
> 
> Symptoms:
> 
> Total system hang.
> Nothing in the logs :-(
> Reboot
> CUPS restart and boom, again and again,...
> 
> Then I went back to 2.4.19-ck5 and boom...
> Several hpijs-1.2.1/1.2.2 versions rechecked. -> Nothing.
> 
> After some thought.
> I have to use "mousedev" and "psmouse" modules since 2.5.40 (-ac3).
> Commented both in my "/etc/rc.d/boot.local" file and started 2.4.19-ck5, 
> again. Bingo ;-)
> 
> But what should I do with 2.5.40+?
> I need my mouse.
> 
> System:
> dual Athlon MP 1900+
> MSI MS-6501 (aka K7D Master-L), Rev 1.0, AMD 760MPX
> 
> Regards,
> 	Dieter
> 
> BTW 2.5.40 is so GREAT on my mixed server/desktop/3D graphics devel maschine.

Hmm how do you know it's mousedev? (99.9% it cannot be the problem.
psmouse could, theoretically, but it's still very unlikely).

Note that you exchanged the whole 2.5 kernel with a 2.4. The crash
could have been anywhere in the kernel, not just the psmouse/mousedev
modules.

-- 
Vojtech Pavlik
SuSE Labs
