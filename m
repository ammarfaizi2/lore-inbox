Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbTAWAKM>; Wed, 22 Jan 2003 19:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbTAWAKL>; Wed, 22 Jan 2003 19:10:11 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:65380 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264724AbTAWAKL>; Wed, 22 Jan 2003 19:10:11 -0500
Date: Wed, 22 Jan 2003 19:19:17 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200301230019.h0N0JHE01172@devserv.devel.redhat.com>
To: "Jacek Radajewski" <jacek@usq.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS YET AGAIN
In-Reply-To: <mailman.1043278441.2751.linux-kernel2news@redhat.com>
References: <mailman.1043278441.2751.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ksymoops 2.4.4 on i686 2.4.18-19.7.xsmp.  Options used

2.4.18-19.7.x should not need ksymoops, because it ships with
kksymoops. In fact, it's harmful, because ksymoops ate the EIP
decoding:

> EIP:    0010:[<f897f51d>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246

Also, the oops does not seem to be related to the BCM card.
Probably your IDE cabling is flakey :)

-- Pete
