Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264276AbTCXRny>; Mon, 24 Mar 2003 12:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264274AbTCXRny>; Mon, 24 Mar 2003 12:43:54 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2012 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264276AbTCXRnx>; Mon, 24 Mar 2003 12:43:53 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303241754.h2OHsii27044@devserv.devel.redhat.com>
Subject: Re: [IDE SiI680] throughput drop to 1/4
To: andre@linux-ide.org (Andre Hedrick)
Date: Mon, 24 Mar 2003 12:54:44 -0500 (EST)
Cc: samel@mail.cz (Vitezslav Samel), alan@redhat.com (Alan Cox),
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10303240943070.8000-100000@master.linux-ide.org> from "Andre Hedrick" at Mar 24, 2003 09:44:38 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There should be a mode or a flag option in the siimage.h to disable MMIO
> by default.  I am courious if this is a BARRIER on the read/write screwing
> the pooch!

It cannot be involved. If you read the code you'll see the SII driver doesnt
yet override outbsync so it can't be involved. We aren't doing any posting
prevention yet
