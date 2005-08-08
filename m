Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVHHKZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVHHKZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 06:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVHHKZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 06:25:41 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:3372 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750810AbVHHKZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 06:25:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=dFzeKWzVzfITgS6DFhv4S1D9c1BKcL+V8ffH7beYbgXrotBkJOHcIH2dMaBqg/KuB/Xbodd0sbesM9ygJ8f0mrqtuzTn0kQkjYHo1ae7jAAI8BqE3xpdW/zAbg/OdEr/bxBE/yRHCwCfz5+DOJa9TOfxVP2izGFOJYGoL7y2Wko=
Date: Mon, 8 Aug 2005 14:33:56 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Achim Leubner <achim_leubner@adaptec.com>
Subject: Re: [PATCH C&C] gdth: remove GDTIOCTL_OSVERS
Message-ID: <20050808103356.GA19957@mipter.zuzino.mipt.ru>
References: <20050807222829.GA20558@mipter.zuzino.mipt.ru> <20050808014027.GI4006@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808014027.GI4006@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 03:40:27AM +0200, Adrian Bunk wrote:
> On Mon, Aug 08, 2005 at 02:28:29AM +0400, Alexey Dobriyan wrote:
> > -      case GDTIOCTL_OSVERS:
> > -      { 
> > -        gdth_ioctl_osvers osv; 
> > -
> > -        osv.version = (unchar)(LINUX_VERSION_CODE >> 16);
> > -        osv.subversion = (unchar)(LINUX_VERSION_CODE >> 8);
> > -        osv.revision = (ushort)(LINUX_VERSION_CODE & 0xff);
> > -        if (copy_to_user(argp, &osv, sizeof(gdth_ioctl_osvers)))
> > -                return -EFAULT;
> > -        break;
> > -      }

> Not that I'd like this, but you know that this is a userspace-visible 
> change?

I know. I also know about uname(2), /proc/sys/kernel/osrelease,
/proc/version, uname(1).

OK, I'll schedule it for removal and give a #warning. How much time
will be enough with everyone? For the record: IMO, it should be zero in
this particular case.

