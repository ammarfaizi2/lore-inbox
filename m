Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269820AbUIDGGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269820AbUIDGGj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 02:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269823AbUIDGGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 02:06:39 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:51304 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269820AbUIDGG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 02:06:28 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kirill Korotaev <dev@sw.ru>
Subject: Re: INIT hangs with tonight BK pull (2.6.9-rc1+)
Date: Sat, 4 Sep 2004 01:06:23 -0500
User-Agent: KMail/1.6.2
Cc: torvalds@osdl.org, wli@holomorphy.com, linux-kernel@vger.kernel.org
References: <200409030204.11806.dtor_core@ameritech.net> <413824B9.8080600@sw.ru>
In-Reply-To: <413824B9.8080600@sw.ru>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409040106.24341.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 September 2004 03:00 am, Kirill Korotaev wrote:
> > After doing BK pull last night INIT gets stuck in do_tty_hangup after
> > executing rc.sysinit. Was booting fine with pull from 2 days ago...
> > 
> > Anyone else seeing this?
> > 
> > I suspect pidhash patch because it touched tty_io.c, but I have not tried
> > reverting it as it is getting too late here... So I apologize in advance
> > if I am pointing finger at the innocent ;)
> 
> Oops, you are right. These do_each_task_pid()/while_each_task_pid() do 
> loop 4ever with 'continue' inside.
> Strange, that I haven't faced the problem on my machine before sending 
> the patch... :(
> 
> Sorry for the inconvinience. Patch is inside.

I see that the patch is already in the kernel proper. Just for the record the
patch fixes my problem and the box boots fine. Thanks, Kirill!
 
-- 
Dmitry
