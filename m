Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWDVU1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWDVU1O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWDVU1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:27:14 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:50637 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751150AbWDVU1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:27:13 -0400
Date: Sat, 22 Apr 2006 13:18:58 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: Hua Zhong <hzhong@gmail.com>, jmorris@namei.org, dwalker@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
In-Reply-To: <20060421144233.1201cf07.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0604221317060.27942@yvahk01.tjqt.qr>
References: <4449486F.8020108@gmail.com> <20060421144233.1201cf07.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Kinda.  It would be better to put all the counters into a linked list

I'd prefer a binary tree which sorts on the caller address and maps these 
addrs to struct someinfo;

>struct likeliness {
>	char *file;
>	int line;
>	atomic_t true_count;
>	atomic_t false_count;
>	struct likeliness *next;
>};

Oh, and if it is going to stay linked list, why not use struct list_head.

Since we are at it, non-NULL counting could also be done, which could give 
an overview who unnecessarily calls kfree too often :>


Jan Engelhardt
-- 
