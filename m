Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVAGBNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVAGBNR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVAGBLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:11:08 -0500
Received: from mail.dif.dk ([193.138.115.101]:53951 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261226AbVAGBGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:06:48 -0500
Date: Fri, 7 Jan 2005 02:18:11 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][0/4] let's kill verify_area
Message-ID: <Pine.LNX.4.61.0501070212560.3430@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


verify_area() if just a wrapper for access_ok() (or similar function or 
dummy function) for all arch's. I say it's time we just get rid of it as 
it no longer serves any purpose and it's easy to convert to access_ok. 
Converting all users may take some time, so initially deprecate it (which 
will get the janitors attention as well as maintainers and ordinary users) 
and then when all users of the function are converted we can kill it and 
all comments related to it.

The following patches deprecate the function for all arch's and then do a 
few initial conversions just to get things moving.

Comments are welcome.


-- 
Jesper Juhl
