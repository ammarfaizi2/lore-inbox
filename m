Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbRLaCLN>; Sun, 30 Dec 2001 21:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286171AbRLaCLE>; Sun, 30 Dec 2001 21:11:04 -0500
Received: from inreach-gw1.idiom.com ([209.209.13.26]:64016 "EHLO
	smile.idiom.com") by vger.kernel.org with ESMTP id <S286161AbRLaCKx>;
	Sun, 30 Dec 2001 21:10:53 -0500
Message-ID: <3C2FC84E.79DB9B9@obviously.com>
Date: Sun, 30 Dec 2001 21:07:10 -0500
From: Bryce Nesbitt <bryce@obviously.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lionel Bouton <Lionel.Bouton@free.fr>, Andries.Brouwer@cwi.nl,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Why would a valid DVD show zero files on Linux?
In-Reply-To: <3C2FB545.BA4544D7@obviously.com> <3C2FB85E.3080508@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lionel Bouton wrote:
> 
> Bryce Nesbitt wrote:
> 
> > I have a DVD ROM (It's DeLorme Topo USA), which works fine booted in Windows.
> > Under Linux it mounts fine, but shows no files.  Everything looks normal, like
> > it should just work.
> >
> > What's up?  And ideas?
> 
> Try udf fs. I don't know the details but I guess a dvd with empty
> iso9660 meta-data but with correct udf meta-data could show these symptoms.

That does it!

Works:
	mount -t udf /dev/hdc /mnt/dvdrom/

Shows no complaints, no log entries, and no files:
	mount -t iso9660 /dev/hdc /mnt/dvdrom/
	mount /dev/hdc /mnt/dvdrom/
	
Does anyone want the first few K of this DVD to see why the autodetection
is not working better?  Do you want me to upgrade past Kernel 2.4.2-2 first?
Is RedHat 7.2's kernel good enough?

Thanks!

		-Bryce
