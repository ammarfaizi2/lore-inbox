Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSGINvW>; Tue, 9 Jul 2002 09:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSGINvW>; Tue, 9 Jul 2002 09:51:22 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:40849 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315337AbSGINvV>; Tue, 9 Jul 2002 09:51:21 -0400
Date: Tue, 9 Jul 2002 14:55:21 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.24] RTL8139: ioctl(SIOCGIFHWADDR): No such device
Message-ID: <20020709125521.GA13892@neon.hh59.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <20020702182820.GA12117@neon.hh59.org> <Pine.LNX.4.44.0207040341040.8135-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207040341040.8135-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Organization: hh59.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kai Germaschewski schrieb am Donnerstag, den 04. Juli 2002:

> On Tue, 2 Jul 2002, Axel Siebenwirth wrote:
> 
> > Since I cannot initialize the network device eth1 for the RTL8139 card, I
> > thought your changes about net_dev_init
> > 
> > <kai@tp1.ruhr-uni-bochum.de>
> >         Make net_dev_init() an __initcall
> > 
> > may have caused this.
> 
> Yes, that seems quite possible. I'll submit a patch which fixes this 
> shortly. In the mean time, you could try to find the __initcall line
> in net/core/dev.c, and replace __initcall by subsys_initcall.
> 
> If you do so, please let me know if it fixes the problem for you.
> 

Still the same problem in 2.5.25. Replacing __initcall with subsys_initcall
fixes it.

Regards,
Axel
