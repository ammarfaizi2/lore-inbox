Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTKIK4k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 05:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTKIK4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 05:56:40 -0500
Received: from nice-1-62-147-25-88.dial.proxad.net ([62.147.25.88]:16644 "EHLO
	monpc") by vger.kernel.org with ESMTP id S262327AbTKIK4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 05:56:39 -0500
From: Guillaume Chazarain <guichaz@yahoo.fr>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Date: Sun, 09 Nov 2003 11:57:39 +0100
X-Priority: 3 (Normal)
Message-Id: <SRLGXA875SP047EDQLEC055ZHDZX2V.3fae1da3@monpc>
Subject: Re: [PATCH] cfq + io priorities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: Opera 6.06 build 1145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A process has an assigned io nice level, anywhere from 0 to 20. Both of

OK, I ask THE question : why not using the normal nice level, via
current->static_prio ?
This way, cdrecord would be RT even in IO, and nice -19 updatedb would have
a minimal impact on the system.

> these end values are "special" - 0 means the process is only allowed to
> do io if the disk is idle, and 20 means the process io is considered

So a process with ioprio == 0 can be forever starved. As it's not
done this way for nice -19 tasks (unlike FreeBSD), wouldn't it be
safer to give a very long deadline to ioprio == 0 requests ?


Thanks for making something I have been dreaming of for a long time :)


Guillaume




