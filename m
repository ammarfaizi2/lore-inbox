Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263783AbREYQGx>; Fri, 25 May 2001 12:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263787AbREYQGn>; Fri, 25 May 2001 12:06:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39439 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263783AbREYQGY>; Fri, 25 May 2001 12:06:24 -0400
Subject: Re: ac15 and 2.4.5-pre6, pwc format conversion
To: randy.dunlap@intel.com (Dunlap, Randy)
Date: Fri, 25 May 2001 17:03:11 +0100 (BST)
Cc: J.A.K.Mouw@ITS.TUDelft.NL ('Erik Mouw'),
        nemosoft@smcc.demon.nl (Nemosoft Unv.),
        preining@logic.at (Norbert Preining), linux-kernel@vger.kernel.org
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE2D1@orsmsx31.jf.intel.com> from "Dunlap, Randy" at May 25, 2001 08:37:26 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153K3T-0006jJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Once upon a time there was an agreement (understanding ?) that this
> was to be a major 2.5 change (moving video conversion from kernel
> drivers to user space) and that lots of apps would need to be
> changed for this to be successful.

Nope. Its been policy since 2.0. Its both v4l1 and v4l2 policy. In fact its
fairly nonsensical to handle any format conversions in kernel unless the
device outputs a unique format of its own.

It breaks apps by doing conversions, and it breaks important apps like H263
codecs not silly little camera viewers, because you trash the performance


