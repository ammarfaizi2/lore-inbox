Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263980AbTCUUOF>; Fri, 21 Mar 2003 15:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263975AbTCUUMv>; Fri, 21 Mar 2003 15:12:51 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:7432 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263980AbTCUUMc>;
	Fri, 21 Mar 2003 15:12:32 -0500
Date: Fri, 21 Mar 2003 12:23:39 -0800
From: Greg KH <greg@kroah.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix kobject_get oopses triggered by i2c in 2.5.65-bk
Message-ID: <20030321202339.GB15561@kroah.com>
References: <20030321195114.GA1313@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321195114.GA1313@vana.vc.cvut.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 08:51:14PM +0100, Petr Vandrovec wrote:
> Hi,
>   
> i2c initialization must not use module_init now, when it was converted
> to the kobject interface. There are dozens of users which need it working
> much sooner. i2c is subsystem after all, isn't it?
> 
> Fixes kernel oopses in kobject_get during system init which were happening
> to me.

Thanks, I've added this to my tree, and will send it on to Linus in the
next round of i2c changes.

thanks,

greg k-h
