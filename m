Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSGQMlS>; Wed, 17 Jul 2002 08:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSGQMlR>; Wed, 17 Jul 2002 08:41:17 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:23209 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313190AbSGQMlQ>;
	Wed, 17 Jul 2002 08:41:16 -0400
Date: Wed, 17 Jul 2002 14:44:10 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 Input Core Support
Message-ID: <20020717144410.A19543@ucw.cz>
References: <3D35435F.E5CFA5E2@delusion.de> <20020717122000.A12529@ucw.cz> <3D355940.96EE8327@delusion.de> <20020717141004.C12529@ucw.cz> <3D355FD0.9F0E4F8@delusion.de> <20020717142933.B19385@ucw.cz> <3D356609.11B46A5C@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D356609.11B46A5C@delusion.de>; from reality@delusion.de on Wed, Jul 17, 2002 at 02:41:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 02:41:45PM +0200, Udo A. Steinberg wrote:
> Vojtech Pavlik wrote:
> > 
> > Ok, another patch. :)
> 
> Very close :)
> Directions of scrolling are reversed. The following works ok:
> 
> diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
> --- a/drivers/input/mouse/psmouse.c     Wed Jul 17 12:19:13 2002
> +++ b/drivers/input/mouse/psmouse.c     Wed Jul 17 12:19:13 2002
> @@ -142,7 +142,7 @@
>   */
> 
>         if (psmouse->type == PSMOUSE_IMEX) {
> -               input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[2] & 7));
> +               input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[3] & 7));
>                 input_report_key(dev, BTN_SIDE, (packet[3] >> 4) & 1);
>                 input_report_key(dev, BTN_EXTRA, (packet[3] >> 5) & 1);
>         }

Can you check with evtest again? Up should be showing as -1, down as 1.
If it doesn't, then there is another direction bug elsewhere.

-- 
Vojtech Pavlik
SuSE Labs
