Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758267AbWLCRmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758267AbWLCRmx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 12:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758275AbWLCRmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 12:42:53 -0500
Received: from mailer-b2.gwdg.de ([134.76.10.29]:19656 "EHLO mailer-b2.gwdg.de")
	by vger.kernel.org with ESMTP id S1758267AbWLCRmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 12:42:52 -0500
Date: Sun, 3 Dec 2006 18:42:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipc:  Convert kmalloc()+memset() to kzalloc() in ipc/.
In-Reply-To: <Pine.LNX.4.64.0612031211560.4877@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0612031842140.25425@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612031211560.4877@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>diff --git a/ipc/sem.c b/ipc/sem.c
>index 21b3289..3c23dc9 100644
>--- a/ipc/sem.c
>+++ b/ipc/sem.c
>@@ -1070,14 +1070,13 @@ static struct sem_undo *find_undo(struct
> 	ipc_rcu_getref(sma);
> 	sem_unlock(sma);
>
>-	new = (struct sem_undo *) kmalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);
>+	new = (struct sem_undo *) kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);

You can drop the case in one go.



	-`J'
-- 
