Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVFOU3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVFOU3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVFOU3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:29:52 -0400
Received: from quechua.inka.de ([193.197.184.2]:47844 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261539AbVFOU3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:29:49 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel summit
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050616.044045.26507987.okuyamak@dd.iij4u.or.jp>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DieWA-0006Tl-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 15 Jun 2005 22:29:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050616.044045.26507987.okuyamak@dd.iij4u.or.jp> you wrote:
> # In other word, why can't I mount device which does not exist,
> # while I can re-mount them?

most likely because the error-case remount does only flip a bit in kernel
space and does not go through all the remount logic. Might be needed to flag
a device broken on global (non sector) errors.

Gruss
Bernd
