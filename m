Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSFRV44>; Tue, 18 Jun 2002 17:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317638AbSFRV4z>; Tue, 18 Jun 2002 17:56:55 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:32779 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317637AbSFRV4y>;
	Tue, 18 Jun 2002 17:56:54 -0400
Date: Tue, 18 Jun 2002 14:55:50 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Harrell 
	<mharrell-dated-1024798178.8a2594@bittwiddlers.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.22 fix for pci_hotplug
Message-ID: <20020618215549.GG21229@kroah.com>
References: <20020618020937.GA2597@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020618020937.GA2597@bittwiddlers.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 21 May 2002 19:19:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 10:09:37PM -0400, Matthew Harrell wrote:
> 
> --- linux/drivers/hotplug/pci_hotplug_core.c-ori	Mon Jun 17 22:01:17 2002
> +++ linux/drivers/hotplug/pci_hotplug_core.c	Mon Jun 17 22:03:33 2002
> @@ -183,13 +183,13 @@
>  /* default file operations */
>  static ssize_t default_read_file (struct file *file, char *buf, size_t count, loff_t *ppos)
>  {
> -	dbg ("\n");
> +	dbg ("%s", "\n");

<snip>

What problem does this fix?

If you _really_ want to fix something, remove the the need for
pci_announce_to_drivers() in the Compaq and IBM PCI hotplug drivers :)

thanks,

greg k-h
