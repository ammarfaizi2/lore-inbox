Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271068AbRH3JAj>; Thu, 30 Aug 2001 05:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271108AbRH3JAT>; Thu, 30 Aug 2001 05:00:19 -0400
Received: from ns.suse.de ([213.95.15.193]:8198 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271068AbRH3JAQ>;
	Thu, 30 Aug 2001 05:00:16 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, manik@cisco.com, linux-kernel@vger.kernel.org
Subject: Re: ioctl conflicts
In-Reply-To: <3B8DEF9D.26F7544D@cisco.com>
	<E15cN49-0000fz-00@the-village.bc.nu>
	<20010830.013023.94071732.davem@redhat.com>
X-Yow: Where do your SOCKS go when you lose them in th' WASHER?
From: Andreas Schwab <schwab@suse.de>
Date: 30 Aug 2001 11:00:29 +0200
In-Reply-To: <20010830.013023.94071732.davem@redhat.com> ("David S. Miller"'s message of "Thu, 30 Aug 2001 01:30:23 -0700 (PDT)")
Message-ID: <jepu9dhqhe.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.105
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

|>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
|>    Date: Thu, 30 Aug 2001 09:20:45 +0100 (BST)
|> 
|>    > I was grep-ing on a 2.4 source tree when i found the
|>    > following :
|>    > 
|>    > ./include/linux/videodev.h:#define VIDIOCGCAP          
|>    > _IOR('v',1,struct video_capability)
|>    > ./include/linux/ext2_fs.h:#define  EXT2_IOC_GETVERSION  _IOR('v',1,
|>    > long)   
|>    
|>    Thats fine. ext2 ioctls and video ioctls go to different places
|> 
|> Consider sparc64.

These ioctl numbers are different due to the different argument size, so
there should be no conflict.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
