Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUKRTQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUKRTQV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbUKRTPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:15:36 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:16772 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262911AbUKRTMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:12:23 -0500
To: hbryan@us.ibm.com
CC: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz, torvalds@osdl.org
In-reply-to: <OFA311AC16.4350B724-ON88256F50.0065969A-88256F50.00677F64@us.ibm.com>
	(message from Bryan Henderson on Thu, 18 Nov 2004 10:49:34 -0800)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OFA311AC16.4350B724-ON88256F50.0065969A-88256F50.00677F64@us.ibm.com>
Message-Id: <E1CUrhZ-0004Kv-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 18 Nov 2004 20:12:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But still -- if the real memory shortage isn't because there's no place to 
> page out to, but rather that the process that's supposed to be writing the 
> pages is deadlocked, the OOM killer will not kick in.

I see your point now.  I'm still not sure that things can go as far as
to totally deadlock the system.  It can stop the writeback from
progressing, but killing the FUSE process still solves the problem.

Miklos
