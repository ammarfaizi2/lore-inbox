Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbTJJQ6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTJJQ6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:58:38 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:442 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263058AbTJJQ6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:58:37 -0400
Message-ID: <3F86E51D.3090605@nortelnetworks.com>
Date: Fri, 10 Oct 2003 12:58:05 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Jamie Lokier <jamie@shareable.org>, Linus Torvalds <torvalds@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
References: <20031010122755.GC22908@ca-server1.us.oracle.com> <Pine.LNX.4.44.0310100756510.20420-100000@home.osdl.org> <20031010152710.GA28773@ca-server1.us.oracle.com> <20031010160144.GI28795@mail.shareable.org> <20031010163300.GC28773@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> On Fri, Oct 10, 2003 at 05:01:44PM +0100, Jamie Lokier wrote:
> 
>>Why don't you _share_ the App's cache with the kernel's?  That's what
>>mmap() and remap_file_pages() are for.

> 	Because you can't force flush/read.  You can't say "I need you
> to go to disk for this."

According to my man pages, this is exactly what msync() is for, no?

>>That's tough to guarantee at the platter level regardless of O_DIRECT,
>>but otherwise: you have fdatasync() and msync().

> 	Platter level doesn't matter.  Storage access level matters.
> Node1 and Node2 have to see the same thing.  As long as I am absolutely
> sure that when Node1's write() returns, any subsequent read() on Node2
> will see the change (normal barrier stuff, really), it doesn't matter
> what happend on the Storage.

Isn't that exactly what msync() exists for?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

