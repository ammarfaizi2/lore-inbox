Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268189AbUIPRM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268189AbUIPRM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268292AbUIPRG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:06:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:48590 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268189AbUIPRCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:02:53 -0400
Date: Thu, 16 Sep 2004 10:00:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stelian Pop <stelian@popies.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-Id: <20040916100050.17a9b341.akpm@osdl.org>
In-Reply-To: <20040916104535.GA3146@crusoe.alcove-fr>
References: <20040913135253.GA3118@crusoe.alcove-fr>
	<20040915153013.32e797c8.akpm@osdl.org>
	<20040916064320.GA9886@deep-space-9.dsnet>
	<20040916000438.46d91e94.akpm@osdl.org>
	<20040916104535.GA3146@crusoe.alcove-fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop <stelian@popies.net> wrote:
>
> Here is the updated patch.

Looks good to me.

You're using `head' as "the place from which `get' gets characters" and
you're using `tail' as "the place where `put' puts characters".  So the
FIFO is, logically:


          tail            head
    * ->  ********************   -> *
     put                         get


I've always done it the other way: you put stuff onto the head and take
stuff off the tail.  Now I have a horid feeling that I've always been
arse-about.  hrm.  
