Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbSLNTnP>; Sat, 14 Dec 2002 14:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbSLNTnP>; Sat, 14 Dec 2002 14:43:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:25095 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265851AbSLNTnN>;
	Sat, 14 Dec 2002 14:43:13 -0500
Date: Sat, 14 Dec 2002 11:49:11 -0800
From: Greg KH <greg@kroah.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, "Eric W.Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] kexec for 2.5.51....
Message-ID: <20021214194911.GB910@kroah.com>
References: <200212141215.49449.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212141215.49449.tomlins@cam.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2002 at 12:15:49PM -0500, Ed Tomlinson wrote:
> Eric W. Biederman wrote:
> 
> > Linus,
> > 
> > My apologies for not resending this earlier I've been terribly
> > busy with other things..
> > 
> > No changes are included since the last time I sent this except
> > the diff now patches cleanly onto 2.5.51.  If there is some problem
> > holler and I will see about fixing it.
> > 
> > When I bypass the BIOS in booting clients my only current failure
> > report is on an IBM NUMAQ and that almost worked.
> 
> I applied this to a 2.5.51 kernel with usb and fbcon updated via bk pulls.
> Then after rebooting into the new kernel I tried
> 
> kexec -l /vmlinux.25 --append="console=tty0 console=ttyS0,38400 video=matrox:mem:32 idebus=33 profile=1"
> kexec -ed
> 
> This rebooted but hangs at:
> 
> drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0

Could you enable CONFIG_USB_DEBUG to hopefully see more debugging
messages from the uhci driver during boot, so we could narrow this down?

thanks,

greg k-h
