Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTCYAUM>; Mon, 24 Mar 2003 19:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261303AbTCYAUM>; Mon, 24 Mar 2003 19:20:12 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:63247 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261302AbTCYAUK>;
	Mon, 24 Mar 2003 19:20:10 -0500
Date: Mon, 24 Mar 2003 16:30:48 -0800
From: Greg KH <greg@kroah.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Gerd Knorr <kraxel@bytesex.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.66
Message-ID: <20030325003048.GC10505@kroah.com>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com> <20030325012252.7aafee8c.us15@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325012252.7aafee8c.us15@os.inf.tu-dresden.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 01:22:52AM +0100, Udo A. Steinberg wrote:
> On Mon, 24 Mar 2003 15:26:47 -0800 (PST) Linus Torvalds (LT) wrote:
> 
> LT> Summary of changes from v2.5.65 to v2.5.66
> LT> ============================================
> LT> Greg Kroah-Hartman <greg@kroah.com>:
> LT>   o i2c i2c-i801.c: remove #ifdefs and fix all printk() to use dev_*()
> LT>   o i2c i2c-i801.c: remove check_region() usage
> LT>   o i2c i2c-i801.c: fix up the pci id matching, and change to use
> LT>     proper pci ids
> LT>   o i2c i2c-i801.c: fix up formatting and whitespace issues
> LT>   o i2c i2c-piix4.c: remove check_region() call
> LT>   o i2c i2c-piix4: remove #ifdefs and fix all printk() to use dev_*()
> LT>   o i2c i2c-piix4.c: fix up formatting and whitespace issues
> LT>   o i2c i2c-ali15x3.c: remove #ifdefs and fix all printk() to use
> LT>     dev_*()
> LT>   o i2c i2c-ali15x3.c: remove check_region() call
> LT>   o i2c i2c-ali15x3.c: fix up formatting and whitespace issues
> LT>   o i2c i2c-amd756.c: remove some #ifdefs and fix all printk() to use
> LT>     dev_*()
> LT>   o i2c i2c-amd8111.c: change a few printk() to dev_warn()
> LT>   o i2c i2c-amd8111.c: change the pci driver name to have "2" in it
> LT>     based on previous comments
> LT>   o i2c: added i2c-isa bus controller driver
> LT>   o i2c: add initial driver model support for i2c drivers
> LT>   o USB: whiteheat bugfix (bugzilla.kernel.org #314)
> LT>   o USB: pegasus: fix up GFP_DMA usages.  (bugzilla.kernel.org #418)
> 
> Hi,
> 
> I guess it's one of the I2C changes which breaks 2.5.66 and bttv, because
> 2.5.65 was still ok and there don't seem to be any relevant bttv changes.
> 
> With 2.5.66 I get a kernel oops with the following backtrace:

Yes, I sent out some patches a few evenings ago to lkml that should fix
this problem.  I'm resyncing them with 2.5.66 right now and will send
them to Linus in a bit.

If you want to get around this for now, in the bttv driver, memset the
i2c_client structure to 0 after it is initialized.  That will solve the
problem.

Hope this helps,

greg k-h
