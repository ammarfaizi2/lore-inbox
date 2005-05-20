Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVETOoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVETOoG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 10:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVETOoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 10:44:06 -0400
Received: from rost.dti.supsi.ch ([193.5.152.238]:49803 "EHLO
	rost.dti.supsi.ch") by vger.kernel.org with ESMTP id S261377AbVETOoD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 10:44:03 -0400
Date: Fri, 20 May 2005 16:43:58 +0200 (CEST)
From: Marco Rogantini <marco.rogantini@supsi.ch>
X-X-Sender: rogantin@rost.dti.supsi.ch
To: "Richard B. Johnson" <linux-os@analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen regen buffer at 0x00b8000
In-Reply-To: <20050520141434.GZ2417@lug-owl.de>
Message-ID: <Pine.LNX.4.62.0505201639170.14709@rost.dti.supsi.ch>
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
 <20050520141434.GZ2417@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 09:48:35 -0400, Richard B. Johnson <linux-os@analogic.com> wrote:

>     if((fd = open("/dev/mem", O_RDWR)) == FAIL)
>         ERRORS("open");
>     if((sp = mmap((void *)SCREEN, len, PROT, TYPE, fd, SCREEN))==MAP_FAILED)
>         ERRORS("mmap");

Try to open("/dev/mem", O_RDWR | O_SYNC). Without this the mapping
will be chached.

 	-marco

