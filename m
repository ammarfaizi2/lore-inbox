Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbUBTU6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 15:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbUBTU6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 15:58:42 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:21449 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261327AbUBTU6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 15:58:40 -0500
Message-ID: <403674F5.2060902@nortelnetworks.com>
Date: Fri, 20 Feb 2004 15:58:29 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible problems with kernel threading code?
References: <40364D01.9030504@nortelnetworks.com> <40366344.9010109@redhat.com>
In-Reply-To: <40366344.9010109@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Not that this is of any interest for this list but what the heck.

I thought that the kernel hangs might be of interest.

> The problem is your code.

>> int schedRc = pthread_setschedparam(t1, policy, &schedParam);
> 
> There is no guarantee that t1 is filled before you it here in the newly
> created thread.  Only when pthread_create() returns is the thread handle
> guaranteed to be written.

Ah, that explains the error.  I'm still trying to track down the kernel 
hangs though.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
