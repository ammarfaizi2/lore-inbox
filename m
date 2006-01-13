Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422723AbWAMQMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422723AbWAMQMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422725AbWAMQMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:12:12 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:56264 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1422723AbWAMQML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:12:11 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 13 Jan 2006 08:12:08 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Howard Chu <hyc@symas.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: epoll_wait, epoll_ctl
In-Reply-To: <43C7AD5A.2000700@symas.com>
Message-ID: <Pine.LNX.4.63.0601130806240.19904@localhost.localdomain>
References: <43C7AD5A.2000700@symas.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, Howard Chu wrote:

> So, what's supposed to happen in a threaded program where one thread does an 
> epoll_ctl on an epoll fd while another thread is currently waiting in 
> epoll_wait on the same fd? In particular, what happens if a thread does an 
> EPOLL_CTL_DEL on one of the fds that is currently being waited on? Is there a 
> possibility of an event being returned on the fd even after the EPOLL_CTL_DEL 
> completes?

The same thing that happens when you close a file on another thread, 
nothing (besides the file being automatically removed from the set). 
Removing a file (either by close or by EPOLL_CTL_DEL) is not an event.



- Davide


