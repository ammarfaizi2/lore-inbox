Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272208AbRHWDzO>; Wed, 22 Aug 2001 23:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272209AbRHWDzF>; Wed, 22 Aug 2001 23:55:05 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:36364 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S272208AbRHWDyq>; Wed, 22 Aug 2001 23:54:46 -0400
Date: Wed, 22 Aug 2001 23:54:58 -0400 (EDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Nicholas Knight <tegeran@home.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC] make ide-scsi more selective
In-Reply-To: <01082215391200.00490@c779218-a>
Message-ID: <Pine.LNX.4.33.0108222350170.18397-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Nicholas Knight wrote:

> Could you elaborate on this? I almost never use modules for my primary 
> desktop system, SCSI emulation support and SCSI generic driver were both 
> compiled in, and I had "hdc=ide-scsi" and later also tried "hdc=scsi" and 

Well, hdc=ide-scsi is for 2.2 and hdc=scsi is for 2.4. Yup, yet another of 
those gratuitious incompatibilities.

> I was unable to read from it with any device, /dev/sr0 /dev/sda /dev/scd0 
> were all dead-ends, but I was able to WRITE just fine... I just don't 
> want to reboot every time I want to write to the drive, nor reboot when I 
> want to READ from it.

I'm not sure why this is happening for you, my CDR drive works for both 
reading and writing using the ide-scsi driver. But it's a known fact that 
ide-scsi is not perfect, so that could explain it.

> Disabling ATAPI CD-ROM support, and enabling SCSI CD-ROM (along with SCSI 
> emulation support and SCSI generic support) worked, and now I just access 
> both my CD-RW drive and my DVD-ROM drive through /dev/sr0 and /dev/sr1.

So now you're saying it *does* work with ide-scsi? I'm utterly confused...

> My primary concern here is other users who haven't figured this out, I 
> know at least one ATAPI/IDE CD-R(W) in Linux HOWTO tells the user that 
> they'll have to use two seperate kernel images, one to allow reading from 
> their drive and the other for writing, infact that was my original method.

Nope. Ide-scsi should be fine for both reading and writing.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

