Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424609AbWKKTJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424609AbWKKTJh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 14:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424608AbWKKTJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 14:09:37 -0500
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:23664 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1424607AbWKKTJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 14:09:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=f4OS21t3rujI0nEQKH0xbtPxrJEq4D6obFJD0wx4CGO1iuMlm4cxufTkVRMOFnEFPc2f2Z7V+LM1493EbPC7M3OVitBbpmMScH7tkBeXJHGOIHRVZu1OAY20mnVN7nBljGvVCZ7beVaCCu2kpdhnQdl1qhctYYuE/6HpQPos1sc=  ;
X-YMail-OSG: P2MJaqQVM1mmsw1GHOrhf9rDcYPojx5Rabywa_PNhS6kAmJktSRFv4HtRzy3csxeyDHe.rlesdWwBYbeuEuLas17Abmyleprku80LG04Jj_i0oO_YZZ3hD3KMu1JiuuxIAfAixR9sIc-
Date: Sat, 11 Nov 2006 11:09:33 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
To: Christoph Hellwig <hch@infradead.org>
Cc: dougg@torque.net, Tejun Heo <htejun@gmail.com>,
       Brice Goglin <Brice.Goglin@ens-lyon.org>,
       Jens Axboe <jens.axboe@oracle.com>,
       Gregor Jasny <gjasny@googlemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       monty@xiph.org, linux-scsi@vger.kernel.org
In-Reply-To: <20061111104642.GA3356@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <589461.23187.qm@web31813.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Nov 10, 2006 at 12:08:15PM -0800, Luben Tuikov wrote:
> > P.S. I'd love to see SG_DXFER_TO_FROM_DEV completely ripped out
> > of sg.c, for obvious reasons.  Can you not duplicate the resid "fix"
> > it provides into "FROM_DEV" -- do apps really rely on it?
> 
> At the beginning of this thread it was mentioned cdparanio uses it.
> But in general we can't just rip out userland interfaces, we pretend
> to have a stable userspace abi (and except for the big sysfs mess that
> actually comes very close to the truth).

The more reason to think things thorougly when introducing
new code and architecture into a kernel.

     Luben

> What we should do is to document very well what SG_DXFER_TO_FROM_DEV
> is doing and that odd name that's been chosen for it.  I'll prepare
> a patch for that.


