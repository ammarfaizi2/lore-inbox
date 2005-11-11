Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbVKKRrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVKKRrQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 12:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbVKKRrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 12:47:16 -0500
Received: from terminus.zytor.com ([192.83.249.54]:53451 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750947AbVKKRrP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 12:47:15 -0500
Message-ID: <4374D913.503@zytor.com>
Date: Fri, 11 Nov 2005 09:46:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 0.99.9g
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43737EC7.6090109@zytor.com> <Pine.LNX.4.63.0511111516170.7575@wbgn013.biozentrum.uni-wuerzburg.de>
In-Reply-To: <Pine.LNX.4.63.0511111516170.7575@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Schindelin wrote:
> 
> Two reasons against renaming:
> 
> - we call it fsck-objects for a reason. We are working on a file system, 
>   which just so happens to be implemented in user space, not kernel space.
>   If lost+found has to find a new name, so does fsck-objects.
> 

I'm sorry, but that is bull.  The problem here isn't the conventional 
naming, it's that you're implementing your filesystem on top of another 
filesystem, and you're running into a layering conflict.

> - lost+found has a special meaning, granted. So, a backup would not be 
>   made of it. So what? I *don't* want it backup'ed. I want to repair what
>   was wrong with it. When I repaired it, the result is stored somewhere
>   else. To backup lost+found would make as much sense as to backup /tmp.
> 

The default should ALWAYS be no data loss.

	-hpa
