Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWI2Qa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWI2Qa4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWI2Qa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:30:56 -0400
Received: from osiris.atheme.org ([69.60.119.211]:59815 "EHLO
	osiris.atheme.org") by vger.kernel.org with ESMTP id S932340AbWI2Qaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:30:55 -0400
In-Reply-To: <0635847A-C149-412C-92B1-A974230381F8@dts.local>
References: <0635847A-C149-412C-92B1-A974230381F8@dts.local>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F2F2C98F-6AFB-4E19-BEE9-D32652E2F478@atheme.org>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: William Pitcock <nenolod@atheme.org>
Subject: Re: [PATCH] include children count, in Threads: field present in /proc/<pid>/status (take-1)
Date: Fri, 29 Sep 2006 11:31:06 -0500
To: girish <girishvg@gmail.com>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sep 29, 2006, at 10:18 AM, girish wrote:

>
> -	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads);
> +	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads +  
> num_children);

Personally, I'd prefer the children count to be separate, something  
like:

buffer += sprintf(buffer, "Threads:\t%d (%d children, %d total)",  
num_threads, num_children, num_threads + num_children);

That would be rather nice, indeed.

Also, next time, make sure that linux-kernel is CC'd, not BCC'd.

---
William Pitcock
nenolod@atheme.org
http://people.atheme.org/~nenolod/
http://nenolod.net


