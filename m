Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSCDPkr>; Mon, 4 Mar 2002 10:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292283AbSCDPkh>; Mon, 4 Mar 2002 10:40:37 -0500
Received: from adsl-62-128-214-206.iomart.com ([62.128.214.206]:20655 "EHLO
	server1.i-a.co.uk") by vger.kernel.org with ESMTP
	id <S290289AbSCDPkT>; Mon, 4 Mar 2002 10:40:19 -0500
Date: Mon, 4 Mar 2002 15:40:07 +0000
From: Andy Jeffries <lkml@andyjeffries.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HPT372 on KR7A-RAID
Message-Id: <20020304154007.62716a6c.lkml@andyjeffries.co.uk>
In-Reply-To: <E16dtBF-0006tG-00@the-village.bc.nu>
In-Reply-To: <20020221091319.37e74cba.lkml@andyjeffries.co.uk>
	<E16dtBF-0006tG-00@the-village.bc.nu>
Organization: Scramdisk Linux
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002 13:22:37 +0000 (GMT), Alan Cox
<alan@lxorguk.ukuu.org.uk> wrote:
> > I don't know if this has been fixed in 2.4.17/18, if it has...sorry!
> > :-)
> 
> Its fixed in 2.4.18-ac at least, and I think in 2.4.18-rc2. Give that a
> go and check its ok

Hi Alan,

It's not fixed in 2.4.18 (released version).

At least, the array of HPT chipsets doesn't have the 372 entry.  Does it
fix it neatly (if the index of the revision is above the array label it as
unknown)?

It doesn't seem to as line 225 in drivers/ide/hpt366.c seems to just use
class_rev as an index in to the chipset_names array (which will bomb out
it it tries to access class_rev=5).

Any chance of getting the earlier patch submitted to the mainstream Kernel
by someone who Linus will listen to ;-)  (P.S. Linus, if you're listening
sorry for the aspersion that you ignore patches from people, it's just
that I am a lowly Kernel newbie who you won't know/trust (YET!)).

Cheers,


-- 
Andy Jeffries
Linux/PHP Programmer

- Windows Crash HOWTO: compile the code below in VC++ and run it!
main (){for(;;){printf("Hung up\t\b\b\b\b\b\b");}}
