Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292515AbSCKR7M>; Mon, 11 Mar 2002 12:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292593AbSCKR7D>; Mon, 11 Mar 2002 12:59:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:34836 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S292515AbSCKR66>;
	Mon, 11 Mar 2002 12:58:58 -0500
Message-ID: <3C8CF054.91290065@gmx.net>
Date: Mon, 11 Mar 2002 18:58:44 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE on linux-2.4.18
In-Reply-To: <Pine.LNX.3.95.1020311120825.2860A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:

> On Mon, 11 Mar 2002, Alan Cox wrote:
>
> > > hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=1024/255/63, UDMA(33)
> > > Partition check:
> > >  hda: hda1 hda2 < hda5 hda6 >
> > > hd: unable to get major 3 for hard disk
> >
> > ^^^^^^^^^^^^^^^^^^
> >
> > Case dismissed ;)
>
> I haven't a clue what you are saying. Every IDE option that is allowed
> is enabled in .config. The IDE drive(s) are found, but you imply, no
> state, that I did something wrong. You state that I haven't enabled
> something? I enabled everything that 'make config` allowed me to
> enable. Now what is it?

You enabled too much(see hd.c):

    dep_bool '  Use old disk-only driver on primary interface'
CONFIG_BLK_DEV_HD_IDE

will hog "major 3" (which is needed by IDE driver later).


