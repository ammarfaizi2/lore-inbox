Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316852AbSGBSbo>; Tue, 2 Jul 2002 14:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSGBSbn>; Tue, 2 Jul 2002 14:31:43 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:25545 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316852AbSGBSbm>; Tue, 2 Jul 2002 14:31:42 -0400
Date: Tue, 2 Jul 2002 20:33:29 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.24] RTL8139: ioctl(SIOCGIFHWADDR): No such device
Message-ID: <20020702183329.GB21708@neon.hh59.org>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
References: <20020701202026.GA896@neon.hh59.org> <3D20BB85.7030504@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D20BB85.7030504@mandrakesoft.com>
User-Agent: Mutt/1.4i
Organization: hh59.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff!

On Mon, 01 Jul 2002, Jeff Garzik wrote:

> Axel Siebenwirth wrote:
> >Have not tried 2.5.23 but 2.5.22 works fine. Since there have been changes 
> >to the 8139too driver I guess thats it. Unfortunately I do not know where 
> >to fix
> >this.

Kai made some changes about net_dev_init ...

<kai@tp1.ruhr-uni-bochum.de>
        Make net_dev_init() an __initcall

        If you were looking to find where net_dev_init() is called, you
wouldn'
t
        have guessed it's in drivers/block/genhd.c, would you?

        Nothing should break if the __initcall net_dev_init is called too
late
        now, since register_netdevice() will call it for us in that case.

With my poor knowledge I guess this could be it?! If you are sure it's not
the 8139too driver.

Regards,
Axel
