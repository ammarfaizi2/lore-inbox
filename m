Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135611AbRD1Tag>; Sat, 28 Apr 2001 15:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135613AbRD1Ta0>; Sat, 28 Apr 2001 15:30:26 -0400
Received: from [209.195.52.31] ([209.195.52.31]:44044 "HELO [209.195.52.31]")
	by vger.kernel.org with SMTP id <S135611AbRD1TaW>;
	Sat, 28 Apr 2001 15:30:22 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Wakko Warner <wakko@animx.eu.org>, Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Date: Sat, 28 Apr 2001 11:21:26 -0700 (PDT)
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <200104281411.QAA04406@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.33.0104281111470.15628-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

at the low end useing a bit of disk for swap doesn't hurt, I ran into a
case a couple years ago on AIX systems. we buy them with 2G ram so that we
don't need to swap, but discovered (the hard way) that we also needed to
allocate 4G of disk space for those boxes (allocating less then 2G meant
that we couldn't use the 2G of RAM). This meant that we had to go out and
buy 2nd hard drives for every machine, just to put the swap files on.

now disks are larger today so it's not as much of an issue, but even with
modern 9-18G drives you can end up eating up 20% or more on a large
machine, this starts to be significant. you can try to say that any box
with that much ram must have lots of disk as well, and most of the time
you will be right, but not all the time. there are cases (webservers for
example) where the machines will be built with lots of RAM and CPU and
little disk becouse they get all their content and put all their logs
elsewhere on the network. in fact with the advances in flash size and the
desire to create high performance clusters, I would not be surprised to
see web node machines produced with no hard drives. it means one less
thing that can break on the system (think a rack of transmeta powered
boxes with no moving parts in the rack except possibly fans)

David Lang

 On
Sat, 28 Apr 2001 R.E.Wolff@BitWizard.nl wrote:

> Date: Sat, 28 Apr 2001 16:11:47 +0200 (MEST)
> From: R.E.Wolff@BitWizard.nl
> To: Wakko Warner <wakko@animx.eu.org>
> Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
>      Xavier Bestel <xavier.bestel@free.fr>,
>      Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
>      William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
>      linux-kernel@vger.kernel.org
> Subject: Re: 2.4 and 2GB swap partition limit
>
> Wakko Warner wrote:
> > > So you've spent almost $200 for RAM, and refuse to spend $4 for 1Gb of
> > > swap space. Fine with me.
>
> > I put this much ram into the system to keep from having swap.  I
> > still say swap=2x ram is a stupid idea.  I fail to see the logic in
> > that.  Disk is much much slower than ram and if you're writing all
> > ram to disk that's also slow.
>
> > I have a machine with 256mb of ram and no disk.  It runs just fine
> > w/o swap. Only reason I even had swap here is if I ran something
> > that used up all my memory and it has happened.
>
> > Since when has linux started to be like windows "our way or no way"?
>
> I've ALWAYS said that it's a rule-of-thumb. This means that if you
> have a good argument to do it differently, you should surely do so!
>
> I maintain a 32M machine without swap. My workstation has 768Mb RAM
> and almost 2G swap:
>
> /home/wolff> free
>              total       used       free     shared    buffers     cached
> Mem:        770872     766724       4148          0     259816      78308
> -/+ buffers/cache:     428600     342272
> Swap:      1843212       1840    1841372
> /home/wolff>
>
> That disk space is just sitting there. Never to be used. I spent $400
> on the RAM, and I'm now reserving about $8 worth of disk space for
> swap. I think that the $8 is well worth it. It keeps my machine
> functional a while longer should something go haywire... As I said:
> If you don't want to see it that way: Fine with me.
>
> 				Roger.
>
>
>
> --
> ** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
> *-- BitWizard writes Linux device drivers for any device you may have! --*
> * There are old pilots, and there are bold pilots.
> * There are also old, bald pilots.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
