Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbUCBPZu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbUCBPZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:25:50 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:28850 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261676AbUCBPZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:25:39 -0500
Message-ID: <4044A764.1030304@nortelnetworks.com>
Date: Tue, 02 Mar 2004 10:25:24 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ben <linux-kernel-junk-email@slimyhorror.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: epoll and fork()
References: <Pine.LNX.4.44.0403020654080.24044-100000@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

> Sorry but what behaviour do you expect by unregistering an fd pushed by 
> the parent from inside a child? Events work exactly the same. Since the 
> context is shared, events are delivered only once.

For principle of least surprise, I would expect that the refcounts would 
be bumped up so that the child could deregister without affecting the 
parent.

Closing the fd in the child doesn't affect the fd in the parent. 
Removing an fd from an fd_set in the child doesn't affect the fd_set in 
the parent.  Unregistering an fd from an epoll set in the child 
shouldn't affect the parent either.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

