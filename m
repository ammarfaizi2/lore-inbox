Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbTBBXxI>; Sun, 2 Feb 2003 18:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbTBBXxI>; Sun, 2 Feb 2003 18:53:08 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:18959 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S265791AbTBBXxH>;
	Sun, 2 Feb 2003 18:53:07 -0500
Date: Mon, 3 Feb 2003 00:57:59 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Compactflash cards dying?
Message-ID: <20030202235759.GA6859@alpha.home.local>
References: <20030202223009.GA344@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030202223009.GA344@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel !

I had this same problem with my very first CF (16 MB) connected to a home-made
IDE adapter. I quickly discovered that the power wire (+5V) had been cut and
that the power was driven through the logic signals, which were strong enough
to let the card work correctly... nearly correctly. Because it got uncorrectable
defects, detected as bad sectors at IDE level. So may be your adapter is too
weak. Or may be you also use it in a battery-powered device which has frequent
power outages ?

Cheers,
Willy

On Sun, Feb 02, 2003 at 11:30:09PM +0100, Pavel Machek wrote:
> Hi!
> 
> I had compactflash from Apacer (256MB), and it started corrupting data
> in few months, eventually becoming useless and being given back for
> repair. They gave me another one and it is just starting to corrupt
> data.
> 
> First time I repartitioned it; now I only did mke2fs, and data
> corruption can be seen by something as simple as
> 
> cat /mnt/cf/mp3/* > /mnt/cf/delme; md5sum /mnt/cf/delme.
> 
> [Fails 1 in 5 tries].
> 
> Anyone seen something similar? Are there some known-good
> compactflash-es?
> 
> 								Pavel
> -- 
> Worst form of spam? Adding advertisment signatures ala sourceforge.net.
> What goes next? Inserting advertisment *into* email?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
