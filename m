Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933424AbWKNMri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933424AbWKNMri (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 07:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933428AbWKNMrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 07:47:37 -0500
Received: from brick.kernel.dk ([62.242.22.158]:14161 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S933424AbWKNMrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 07:47:35 -0500
Date: Tue, 14 Nov 2006 13:50:14 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Monty Montgomery <monty@xiph.org>, Tejun Heo <htejun@gmail.com>,
       Gregor Jasny <gjasny@googlemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Douglas Gilbert <dougg@torque.net>
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
Message-ID: <20061114125014.GE22178@kernel.dk>
References: <20061030132745.GE4563@kernel.dk> <4552F905.3020109@ens-lyon.org> <45533468.1060400@gmail.com> <806dafc20611091209s5864c9eam77a9290194de343d@mail.gmail.com> <20061110161510.GC15031@kernel.dk> <4554A681.2000502@ens-lyon.org> <20061110162330.GE15031@kernel.dk> <4559B580.3070201@ens-lyon.org> <20061114122914.GD22178@kernel.dk> <4559B92E.4010003@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4559B92E.4010003@ens-lyon.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14 2006, Brice Goglin wrote:
> Jens Axboe wrote:
> > On Tue, Nov 14 2006, Brice Goglin wrote:
> >   
> >> I just tried commit 616e8a091a035c0bd9b871695f4af191df123caa on top of
> >> rc5 just in case. This commit fixes
> >> http://lkml.org/lkml/2006/10/13/100, which looks related. And it
> >> actually appears to fix our freeze too. Does this speak to you guys ?
> >>     
> >
> > I thought you had already tested that?
> 
> IIRC, the one I tested was
> http://marc.theaimsgroup.com/?l=linux-scsi&m=116267031029025&w=2. It
> does something similar in sg.c instead of scsi_ioctl.c.

You most likely aren't using sg, but the block layer direct path. So no
wonder it didn't change anything.

-- 
Jens Axboe

