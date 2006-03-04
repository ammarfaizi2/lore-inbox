Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751891AbWCDS4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbWCDS4O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 13:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbWCDS4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 13:56:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47876 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751891AbWCDS4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 13:56:13 -0500
Date: Sat, 4 Mar 2006 19:56:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Nick Warne <nick@linicks.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: [2.4 patch] Corrected faulty syntax in drivers/input/Config.in
Message-ID: <20060304185612.GM9295@stusta.de>
References: <20060303180100.GV9295@stusta.de> <7c3341450603031226o55f6c77ah@mail.gmail.com> <Pine.LNX.4.61.0603041943170.29991@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603041943170.29991@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 07:44:01PM +0100, Jan Engelhardt wrote:
> >> If statement in drivers/input/Config.in for "make xconfig" corrected.
> >>
> >> Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
> >> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >>
> >> --- a/drivers/input/Config.in
> >> +++ b/drivers/input/Config.in
> >> @@ -8,7 +8,7 @@ comment 'Input core support'
> >>  tristate 'Input core support' CONFIG_INPUT
> >>  dep_tristate '  Keyboard support' CONFIG_INPUT_KEYBDEV $CONFIG_INPUT
> >>
> >> -if [ "$CONFIG_INPUT_KEYBDEV" == "n" ]; then
> >> +if [ "$CONFIG_INPUT_KEYBDEV" = "n" ]; then
> >>         bool '  Use dummy keyboard driver' CONFIG_DUMMY_KEYB $CONFIG_INPUT
> >>  fi
> 
> If this is sh compatible code, then == is just as valid -- if xconfig 

It is not.

> breaks then, then xconfig is broken, not the file.

Please read at least the section "Introduction" of 
Documentation/kbuild/config-language.txt in kernel 2.4
instead of falsely accusing xconfig of being broken.

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

