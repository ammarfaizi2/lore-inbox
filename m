Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVDEKKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVDEKKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVDEKGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 06:06:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9422 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261690AbVDEKFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 06:05:02 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.62.0504042326220.2496@dragon.hyggekrogen.localhost> 
References: <Pine.LNX.4.62.0504042326220.2496@dragon.hyggekrogen.localhost> 
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no need to cast pointer to (void *) when passing it to kfree() 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Tue, 05 Apr 2005 11:04:58 +0100
Message-ID: <26741.1112695498@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:

> kfree() takes a void pointer argument, no need to cast.

vma->vm_start is unsigned long (unless it's changed since last I looked):

	struct vm_area_struct {
		struct mm_struct * vm_mm;
		unsigned long vm_start;
		unsigned long vm_end;

Davod
