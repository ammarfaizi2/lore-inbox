Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284356AbRLHTGZ>; Sat, 8 Dec 2001 14:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284357AbRLHTGQ>; Sat, 8 Dec 2001 14:06:16 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:26240 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S284356AbRLHTGH>;
	Sat, 8 Dec 2001 14:06:07 -0500
Date: Sat, 8 Dec 2001 14:06:06 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Chris Friesen <chris_friesen@sympatico.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: how to set motherboard chipset registers
In-Reply-To: <3C11100F.6B2D67F1@sympatico.ca>
Message-ID: <Pine.LNX.4.30.0112081402220.2244-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can use the userspace utility called 'setpci' which, if run as root,
allows you to tweak such things.  For insance, say you wanted to set byte
register 0x55 to value 0x1c on a pci device who's vendor/device id combo
is 1106:3099, you would do:

setpci -d 1106:3099 55.B=1c

To query this register without setting anything, do:

setpci -d 1106:3099 55.B

And, of course, man setpci will sell you more.. :)

On Fri, 7 Dec 2001, Chris Friesen wrote:

>
> I'm just wondering what would be the best way to get/set chipset
> registers (for tweaking purposes) in linux.  What is the proper way to
> address these things given bit numbers and offsets?
>
> I'm a decent coder, I've done low-level hardware stuff before, but I
> just don't know where to start with this.
>
> Thanks,
>
> Chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

