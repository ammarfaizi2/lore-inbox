Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292889AbSBVXo6>; Fri, 22 Feb 2002 18:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293043AbSBVXos>; Fri, 22 Feb 2002 18:44:48 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:60171 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S292889AbSBVXoi>; Fri, 22 Feb 2002 18:44:38 -0500
Date: Sat, 23 Feb 2002 00:44:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Greg KH <greg@kroah.com>, G?rard Roudier <groudier@free.fr>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020223004436.B9809@suse.cz>
In-Reply-To: <20020222200750.GE9558@kroah.com> <Pine.LNX.4.10.10202221204400.2519-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202221204400.2519-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Fri, Feb 22, 2002 at 12:09:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 12:09:47PM -0800, Andre Hedrick wrote:
 
> > > Propose a kernel API that does not break more features that it adds and I
> > > will be glad to use it.
> > 
> > Huh?  This is not a new API.  What does it break for you?
> 
> The problem is how do you deal with multiple HOSTs given there drivers are
> not (have not checked lately) capable of discrete HOST addition and
> removal.
> 
> SCSI/ATA share the same problem IIRC, the host/chipset drivers load all
> the device hosts who match that driver code.
> 
> What am I missing?

The fact that even though you have one module for the whole family of
host controllers, the hotplug API will only call the remove function of
the one instance of the host controller that is being removed, not
affecting the others.

-- 
Vojtech Pavlik
SuSE Labs
