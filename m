Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292259AbSBBJ5V>; Sat, 2 Feb 2002 04:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292260AbSBBJ5K>; Sat, 2 Feb 2002 04:57:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8455 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S292259AbSBBJ47>;
	Sat, 2 Feb 2002 04:56:59 -0500
Date: Sat, 2 Feb 2002 10:56:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Brak <brak@waste.org>, linux-kernel@vger.kernel.org,
        "Leonard N. Zubkoff" <lnz@dandelion.com>, Dave Jones <davej@suse.de>
Subject: Re: PROBLEM: 2.5.3 DAC960 won't compile
Message-ID: <20020202105612.M12156@suse.de>
In-Reply-To: <Pine.LNX.4.44.0202011752200.7986-100000@waste.org> <20020202062116.7b4fb074.johnpol@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020202062116.7b4fb074.johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02 2002, Evgeniy Polyakov wrote:
> On Fri, 1 Feb 2002 17:54:18 -0600 (CST)
> Brak <brak@waste.org> wrote:
> 
> > 
> > When compiling the 2.5.3 kernel it errors out on the DAC960
> > 
> 
> I hope this patch will help you.
> 
>   This program is distributed in the hope that it will be useful, but
>   WITHOUT ANY WARRANTY, without even the implied warranty of
> MERCHANTABILITY  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
> Public License  for complete details.
> 
> So, this patch may broke things...

Please don't send this patch in for inclusion, it's broken it several
places. Subtly broken, which means it could take ages for it to be fixed
for real... Hint: a bio can contain more than one page.

I really do appreciate folks trying to fix up block drivers, but please
send the patches through me for verification.

Plus, DAC960 will break as soon as ->address disappears from the
scatterlist. It has been in dire need of a pci api conversion for a
loooong time. Leonard, what is the status on this?

-- 
Jens Axboe

