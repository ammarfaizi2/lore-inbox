Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292989AbSBVUfO>; Fri, 22 Feb 2002 15:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292990AbSBVUfH>; Fri, 22 Feb 2002 15:35:07 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:47376 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292989AbSBVUez>;
	Fri, 22 Feb 2002 15:34:55 -0500
Date: Fri, 22 Feb 2002 12:29:17 -0800
From: Greg KH <greg@kroah.com>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222202917.GF9558@kroah.com>
In-Reply-To: <20020222200750.GE9558@kroah.com> <Pine.LNX.4.10.10202221204400.2519-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10202221204400.2519-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 25 Jan 2002 16:56:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 12:09:47PM -0800, Andre Hedrick wrote:
> 
> Does INT13/INT19 Bios call mean anything?

To me, no.  I do not know anything about IDE.  :)

I thought we were talking about SCSI PCI drivers here.

> The problem is how do you deal with multiple HOSTs given there drivers are
> not (have not checked lately) capable of discrete HOST addition and
> removal.
> 
> SCSI/ATA share the same problem IIRC, the host/chipset drivers load all
> the device hosts who match that driver code.
> 
> What am I missing?

Nothing.  It is the same problem for IDE PCI drivers.  In order for PCI
Hotplug to work on these devices, they have to implement the 2.4 pci
interface.  If they do that, they work with PCI hotplug systems.  If
they do not, they don't.

thanks,

greg k-h
