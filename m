Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbVA2FRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbVA2FRa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 00:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbVA2FRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 00:17:30 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:37602 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262854AbVA2FRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 00:17:25 -0500
Date: Fri, 28 Jan 2005 20:33:05 -0500
From: Christopher Li <chrisl@vmware.com>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: linux kernel mail list <linux-kernel@vger.kernel.org>
Subject: Re: compat ioctl for submiting URB
Message-ID: <20050129013305.GA7792@64m.dyndns.org>
References: <20050128212304.GA11024@64m.dyndns.org> <1106972991.3972.57.camel@sherbert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106972991.3972.57.camel@sherbert>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for the case that running 32 bit application on
a 64 bit kernel. So far only x86_64 allow you to do that.

I am not aware of other 64bit architecture need the 32bit
emulation.

Chris

On Sat, Jan 29, 2005 at 04:29:51AM +0000, Gianni Tedesco wrote:
> On Fri, 2005-01-28 at 16:23 -0500, Christopher Li wrote:
> > +#ifdef CONFIG_IA32_EMULATION
> > +
> > +       case USBDEVFS_SUBMITURB32:
> > +               snoop(&dev->dev, "%s: SUBMITURB32\n", __FUNCTION__);
> > +               ret = proc_submiturb_compat(ps, p);
> > +               if (ret >= 0)
> > +                       inode->i_mtime = CURRENT_TIME;
> > +               break;
> > +#endif
> 
> Why don't other 64bit architectures need this chunk?
> 
> -- 
> // Gianni Tedesco (gianni at scaramanga dot co dot uk)
> lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
> 
