Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUFODoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUFODoj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 23:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbUFODoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 23:44:39 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:12012 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264763AbUFODoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 23:44:37 -0400
Message-ID: <40CE70A3.7040800@mvista.com>
Date: Mon, 14 Jun 2004 22:44:35 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: minyard@mvista.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.7-rc3 drivers/char/ipmi/ipmi_devintf.c: user/kernel
 pointer typo
References: <1086822299.32056.134.camel@dooby.cs.berkeley.edu>
In-Reply-To: <1086822299.32056.134.camel@dooby.cs.berkeley.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are obviously right, and it looks like the fix is in the newest 
release candidate.  Thanks for finding this.

-Corey

Robert T. Johnson wrote:

>Judging from context, I think there's a misplaced "&" in this code that
>can cause stack overflows and other nasty problems.  Perhaps it's left 
>over from when msgdata was an array instead of a pointer?  Let me know 
>if you have any questions or I made a mistake.
>
>Best,
>Rob
>
>
>--- linux-2.6.7-rc3-full/drivers/char/ipmi/ipmi_devintf.c.orig	Wed Jun  9 12:08:23 2004
>+++ linux-2.6.7-rc3-full/drivers/char/ipmi/ipmi_devintf.c	Wed Jun  9 12:07:09 2004
>@@ -199,7 +199,7 @@ static int handle_send_req(ipmi_user_t  
> 			goto out;
> 		}
> 
>-		if (copy_from_user(&msgdata,
>+		if (copy_from_user(msgdata,
> 				   req->msg.data,
> 				   req->msg.data_len))
> 		{
>
>
>
>  
>


