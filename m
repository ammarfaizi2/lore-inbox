Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283697AbRLISFM>; Sun, 9 Dec 2001 13:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283698AbRLISFC>; Sun, 9 Dec 2001 13:05:02 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:2632 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283697AbRLISEw>;
	Sun, 9 Dec 2001 13:04:52 -0500
Date: Sun, 9 Dec 2001 19:04:45 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: "James Stevenson" <mistral@stev.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/stat and disk_io
Message-Id: <20011209190445.28303785.rene.rebe@gmx.net>
In-Reply-To: <003801c180cd$51055700$0801a8c0@Stev.org>
In-Reply-To: <003801c180cd$51055700$0801a8c0@Stev.org>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2001 16:19:45 -0000
"James Stevenson" <mistral@stev.org> wrote:

> Hi
> 
> >from /proc/stat i get the following
> 
> disk_io: (3,0):(167751,94458,3917566,73293,2420568)
> (3,1):(59314,45093,2747844,14221,114376)
> (11,0):(9855,9855,1258392,0,0)
> 
> except the device 11,0 is a cd-reader
> and there is a device 11,1 which has been used
> is there any reson why the stats dont show up ?
> after all it is another disk.

Linux definetly broken in this area! Linux (2.4) does not report other
any devices over either major 16 or minor 16. e.g. no /dev/hdb or /dev/hdd.

For my 4 IDE disk (on two different controllers) I only get:

disk_io: (3,0):(355075,157636,1744492,197439,2633848)

...

I'm thinking about fixing this on my onw using this patch as base:

http://www.swanson.uklinux.net/patch-diskio-2.4.16-1

> thanks
>     James
> 
> 
> --------------------------
> Mobile: +44 07779080838
> http://www.stev.org
>   4:10pm  up 1 day, 17:44,  2 users,  load average: 0.08, 0.08, 0.02


k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
