Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbULQUyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbULQUyO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 15:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbULQUyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 15:54:14 -0500
Received: from falcon30.maxeymade.com ([24.173.215.190]:16516 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S262161AbULQUxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 15:53:40 -0500
Message-Id: <200412172053.iBHKrJ29013356@falcon30.maxeymade.com>
X-Mailer: exmh version 2.7.1.1 10/09/2004 with nmh-1.1
In-reply-to: <20041217192813.GK3140@suse.de> 
To: Jens Axboe <axboe@suse.de>
cc: Doug Maxey <dwm@maxeymade.com>, kronos@kronoz.cjb.net,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rashkae <rashkae@tigershaunt.com>
Subject: Re: Cannot mount multi-session DVD with ide-cd, must use ide-scsi 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Dec 2004 14:53:19 -0600
From: Doug Maxey <dwm@maxeymade.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Dec 2004 20:28:13 +0100, Jens Axboe wrote:
>On Fri, Dec 17 2004, Doug Maxey wrote:
>> 
>> On Fri, 17 Dec 2004 19:33:03 +0100, Kronos wrote:
>> ...
>> > 		if (stat) return stat;
>> >+	
>> >+		toc->last_session_lba = be32_to_cpu(ms_tmp.ent.addr.lba);
>> 
>> Should that be le32_to_cpu?
>
>Why? It's read data and that is always big-endian.

after paying closer attention, this is data from the *media*.  yup, 
that is the correct conversion. :-/

++doug

