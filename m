Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVBHQlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVBHQlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVBHQlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:41:42 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:195 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261579AbVBHQk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:40:56 -0500
Subject: Re: [PATCH] raw1394 : Fix hang on unload
From: Parag Warudkar <kernel-stuff@comcast.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
In-Reply-To: <1107872677l.6054l.0l@werewolf.able.es>
References: <1107718875.4378.25.camel@localhost.localdomain>
	 <20050207101914.GA16686@hugang.soulinfo.com>
	 <1107872677l.6054l.0l@werewolf.able.es>
Content-Type: text/plain
Date: Tue, 08 Feb 2005 11:40:52 -0500
Message-Id: <1107880852.4154.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I looked also at other 1394 drivers and all have the calls in 'bad' order.
> Sure this ordering has to be reversed or it is correct and is triggering
> other hidden bug ?
> 
Quite possibly it's triggering (or is triggered by) some other bug. 
There is also a possibility that raw1394.c might be doing something
wrong and gets away with it with the changed ordering. Because dv1394.c
does it the "seemingly-bad" way and I haven't got rmmod to hang while
removing it.

Can anyone answer this - in what  cases will generic_delete_inode hang
on __down_failed -> default_wake_function -> __down?

Thanks

Parag

