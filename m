Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272236AbTHDU1M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272238AbTHDU1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:27:12 -0400
Received: from quechua.inka.de ([193.197.184.2]:36835 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S272236AbTHDU1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:27:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: chroot() breaks syslog() ?
References: <6416776FCC55D511BC4E0090274EFEF5080024AC@exchange.world.net> <20030804133307.GA4225@www.13thfloor.at>
Organization: private Linux site, southern Germany
Date: Mon, 04 Aug 2003 22:19:16 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E19jlnZ-00023P-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IMHO, devfs in chroot environment, is defeating the purpose
> because if you have access to raw devices, like the device
> your chroot dir is on, you can easily mount that device
> again, and voila you have access to the full tree, if you

You need to be root to mount the device, and as root you can also create
the device special file. A chroot environment does not reliably guard
against root breaking out of it.

Olaf

