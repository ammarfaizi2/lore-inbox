Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289739AbSA2QyY>; Tue, 29 Jan 2002 11:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289754AbSA2QyO>; Tue, 29 Jan 2002 11:54:14 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:34063 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S289739AbSA2QyA>;
	Tue, 29 Jan 2002 11:54:00 -0500
Message-ID: <3C56D38E.C7FD34B3@gmx.net>
Date: Tue, 29 Jan 2002 17:53:34 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Ethernet data corruption?
In-Reply-To: <mailman.1012246740.9237.linux-kernel2news@redhat.com> <200201281956.g0SJuH725438@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

> >       The other night, my friend was sending me a video over the internet.
> > We tried http, ftp, and other protocols, using different download
> > applications.  It seemed to be corrupt, the same way, everytime.  It
> > wouldn't work, and had a different md5sum than the "good" version on my
> > friend's computer.  Eventually we got it working.
> >[...]
>
> Two things are likely:
>
> 1. a firewall mangles your TCP streams
>
> 2. something is wrong between the driver and the NIC.

3. An error source in the transmission path exchanging 0x00 0x00
against 0xff 0xff sequences will go undetected by TCP CRC.

"diff -u" onto "od"-output will help understanding your error pattern.

