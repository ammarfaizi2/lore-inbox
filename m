Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUIONjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUIONjT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUIONhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:37:04 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:53953 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266243AbUIONex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:34:53 -0400
Subject: Re: [patch] tune vmalloc size
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040915125356.GA11250@elte.hu>
References: <20040915125356.GA11250@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095251478.19893.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Sep 2004 13:31:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-15 at 13:53, Ingo Molnar wrote:
> there are a few devices that use lots of ioremap space. vmalloc space is
> a showstopper problem for them.
> 
> this patch adds the vmalloc=<size> boot parameter to override
> __VMALLOC_RESERVE. The default is 128mb right now - e.g. vmalloc=256m
> doubles the size.

Is there a reason for defaulting to such a small allocation even on
4G/4G platforms ?

