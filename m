Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319106AbSH2GNW>; Thu, 29 Aug 2002 02:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319108AbSH2GNW>; Thu, 29 Aug 2002 02:13:22 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:65458 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319106AbSH2GNV>;
	Thu, 29 Aug 2002 02:13:21 -0400
Date: Thu, 29 Aug 2002 08:17:36 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: input u-cleanup
Message-ID: <20020829081736.A23935@ucw.cz>
References: <20020828220603.GA30107@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020828220603.GA30107@elf.ucw.cz>; from pavel@ucw.cz on Thu, Aug 29, 2002 at 12:06:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 12:06:03AM +0200, Pavel Machek wrote:
> Hi!
> 
> proc is clever enough not to need ifdefs, so this is probably good
> idea...
> 
> 								Pavel

If you could remove all the procfs #ifdefs from input.c, that'd be great.
But removing only those around unregistration IMHO doesn't make sense.

> 
> --- clean/drivers/input/input.c	Wed Aug 28 22:38:46 2002
> +++ linux-swsusp/drivers/input/input.c	Wed Aug 28 23:28:23 2002
> @@ -800,11 +803,9 @@
>  
>  static void __exit input_exit(void)
>  {
> -#ifdef CONFIG_PROC_FS
>  	remove_proc_entry("devices", proc_bus_input_dir);
>  	remove_proc_entry("handlers", proc_bus_input_dir);
>  	remove_proc_entry("input", proc_bus);
> -#endif
>  	devfs_unregister(input_devfs_handle);
>          if (unregister_chrdev(INPUT_MAJOR, "input"))
>                  printk(KERN_ERR "input: can't unregister char major %d", INPUT_MAJOR);
> 
> -- 
> Worst form of spam? Adding advertisment signatures ala sourceforge.net.
> What goes next? Inserting advertisment *into* email?

-- 
Vojtech Pavlik
SuSE Labs
