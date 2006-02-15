Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWBOUFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWBOUFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWBOUFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:05:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48355 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751274AbWBOUFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:05:03 -0500
Date: Wed, 15 Feb 2006 12:03:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: carsteno@de.ibm.com
Cc: cotte@de.ibm.com, hch@lst.de, horst.hummel@de.ibm.com,
       linux-kernel@vger.kernel.org, heicars2@de.ibm.com, wein@de.ibm.com,
       mschwid2@de.ibm.com, ihno@suse.de
Subject: Re: [PATCH 0/5] new dasd ioctl patchkit
Message-Id: <20060215120343.1e4e8afe.akpm@osdl.org>
In-Reply-To: <43F3397B.3090207@de.ibm.com>
References: <1139935988.6183.5.camel@localhost.localdomain>
	<20060214190909.GA20527@lst.de>
	<43F3397B.3090207@de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Otte <cotte@de.ibm.com> wrote:
>
> Christoph Hellwig wrote:
> > As long as we backout the bogus eer
> > patch before 2.6.16 all the cleanups and even the eckd ioctl fix
> > can wait.  But don't put this crappy interface into 1.6.16 and thus
> > SLES10 so that applications start to rely on it.
> ACK: Given that a) both Horst and Christoph think the ioctl interface
> needs cleanup but proposed cleanup interfers with existing
> functionality (cmb), and b) later cleanup would change the
> user-interface of eer, we should rush neither the ioctl change nor
> eer into .16 until the maintainer is back afaics.
> 

I don't have a patch in hand to purely back out the eer modeule.  What I
have is

dasd-cleanup-dasd_ioctl.patch
dasd-cleanup-dasd_ioctl-fix.patch
dasd-add-per-disciple-ioctl-method.patch
dasd-merge-dasd_cmd-into-dasd_mod.patch
dasd-backout-dasd_eer-module.patch
dasd-kill-dynamic-ioctl-registration.patch

So what do we do?
