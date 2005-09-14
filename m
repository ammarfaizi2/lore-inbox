Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbVINKdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbVINKdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 06:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbVINKdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 06:33:09 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:35496 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932704AbVINKdI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 06:33:08 -0400
Subject: Re: kbuild-permanently-fix-kernel-configuration-include-mess.patch
	added to -mm tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, linux-kernel@vger.kernel.org,
       sam@ravnborg.org
In-Reply-To: <20050914102016.B30672@flint.arm.linux.org.uk>
References: <200509140841.j8E8fG1w022954@shell0.pdx.osdl.net>
	 <2cd57c900509140205572f19b7@mail.gmail.com>
	 <20050914102016.B30672@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Sep 2005 11:58:17 +0100
Message-Id: <1126695497.19133.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-09-14 at 10:20 +0100, Russell King wrote:
> That is a small price to pay, rather than having to continually maintain
> "does this file need config.h included" - which I think can conclusively
> be shown to be a total lost cause.  There are about 3450 configuration
> include errors in the kernel as of -git last night.

I think your proposal makes sense. The alternative is to do a config
check each build for a while after the config pass and refuse to build
if the header check fails 8). That I suspect would rapidly see config.h
directly or indirectly in every file.

