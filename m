Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbTJDXIj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 19:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbTJDXIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 19:08:39 -0400
Received: from [207.175.35.50] ([207.175.35.50]:45592 "EHLO
	alpha.eternal-systems.com") by vger.kernel.org with ESMTP
	id S262799AbTJDXIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 19:08:38 -0400
Message-ID: <3F7F5294.1090606@eternal-systems.com>
Date: Sat, 04 Oct 2003 16:07:00 -0700
From: Vishwas Raman <vishwas@eternal-systems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Accessing tcp socket information from within a module
References: <3F7E0DFF.2030404@eternal-systems.com> <20031003225124.17a440c2.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Fri, 03 Oct 2003 17:02:07 -0700
> Vishwas Raman <vishwas@eternal-systems.com> wrote:
> 
> 
>>Is there some way of accessing the information of all open tcp sockets 
>>in the system, other than having to turn one of IPV6 or KHTTPD on?
> 
> 
> You don't even need to write your kernel module, there is already
> a special netlink socket provided to userspace exactly for this
> purpose, to get info on all TCP sockets efficiently.
> 
> See net/ipv4/tcp_diag.c
> 

But what if I am interested in doing the same in kernel space and not 
user space? The module I am writing is going to sit between the tcp and 
ip layers of the networking stack. And I need to get info on all TCP 
sockets and create/modify certain data structures of my own in the 
module based on that information.


