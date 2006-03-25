Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWCYSmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWCYSmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWCYSme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:42:34 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:28308 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932183AbWCYSme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:42:34 -0500
Date: Sat, 25 Mar 2006 19:41:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Darren Jenkins <darrenrjenkins@gmail.com>
Subject: Re: [2.6 patch] fix array over-run in efi.c
In-Reply-To: <20060325115853.GB4053@stusta.de>
Message-ID: <Pine.LNX.4.61.0603251941111.29793@yvahk01.tjqt.qr>
References: <20060325115853.GB4053@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-		for (i = 0; i < sizeof(vendor) && *c16; ++i)
>+		for (i = 0; i < (sizeof(vendor) - 1) && *c16; ++i)

                for (i = 0; i <  sizeof(vendor) - 1  && *c16; ++i)
Should suffice.


Jan Engelhardt
-- 
