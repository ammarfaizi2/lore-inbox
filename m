Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264965AbSKERPJ>; Tue, 5 Nov 2002 12:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbSKERPI>; Tue, 5 Nov 2002 12:15:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30481 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264965AbSKERPG>;
	Tue, 5 Nov 2002 12:15:06 -0500
Message-ID: <3DC7FE25.8050806@pobox.com>
Date: Tue, 05 Nov 2002 12:21:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171303.GA20881@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Tue, Nov 05, 2002 at 12:08:33PM -0500, Jeff Garzik wrote:
>
> > >Can it really be that one cannot edit a config file and run make
> > >oldconfig anymore? I'm used to editing an entry in .config and running
> > >oldconfig to fix things up, now it just reenables the option. That's
> > >clearly a major regression.
> > > 
> > It works fine for me :)
> > I don't think I could survive without the tried and true "vi .config ; 
> > make oldconfig" kernel configurator :)
>
>Here it seems to work fine if I delete a line completely, but
>if I change
>CONFIG_FOO=y
>to
>#CONFIG_FOO=y
>
>it regenerates .config without the #
>This used to work fine. I guess the new parser
>is a little more strict..
>  
>


well, consider too that '# blah blah' was never really a 
completely-free-to-use namespace, it was considered special due to the 
shell-based parsing that needed to occur.  '# CONFIG_FOO is not set' is 
the classic example of using the '#' space...

    Jeff




