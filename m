Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUHOUyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUHOUyN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266897AbUHOUyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:54:13 -0400
Received: from AGrenoble-152-1-30-171.w82-122.abo.wanadoo.fr ([82.122.148.171]:11976
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S266891AbUHOUyL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:54:11 -0400
Subject: Re: Linux SATA RAID FAQ
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092520163.27405.11.camel@localhost.localdomain>
References: <E1BvFmM-0007W5-00@calista.eckenfels.6bone.ka-ip.net>
	 <1092315392.21994.52.camel@localhost.localdomain> <411BA7A1.403@pobox.com>
	 <411BA940.5000300@pobox.com>
	 <1092520163.27405.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1092603242.7421.6.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 22:54:02 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam 14/08/2004 à 23:49, Alan Cox a écrit :
> > > * Caching
> 
> Is it battery backed ? If it is battery backed then its useful, if not
> then it becomes less useful although not always. The i2o drivers have
> some ioctls so you can turn on writeback caching even without battery
> backup. While this is suicidal for filesytems its just great for swap..

Isn't sufficient to have it do ordered writes ? If you power your
machine off, you'll have things half-written anyway, the only thing
important with journaled filesystems (and raid5 arrays) is to have
writes staying between barriers.

	Xav

