Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTJJRdq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 13:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262970AbTJJRdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 13:33:46 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:12000 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262960AbTJJRdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 13:33:45 -0400
Message-ID: <3F86ED5D.8040503@nortelnetworks.com>
Date: Fri, 10 Oct 2003 13:33:17 -0400
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
References: <20031010122755.GC22908@ca-server1.us.oracle.com> <Pine.LNX.4.44.0310100756510.20420-100000@home.osdl.org> <20031010152710.GA28773@ca-server1.us.oracle.com> <20031010160144.GI28795@mail.shareable.org> <20031010163300.GC28773@ca-server1.us.oracle.com> <3F86E51D.3090605@nortelnetworks.com> <20031010172001.GA29301@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> On Fri, Oct 10, 2003 at 12:58:05PM -0400, Chris Friesen wrote:
> 
>>>	Because you can't force flush/read.  You can't say "I need you
>>>to go to disk for this."
>>>
>>According to my man pages, this is exactly what msync() is for, no?
>>
> 
> 	msync() forces write(), like fsync().  It doesn't force read().

Oh, of course.

So do the applications know when they need to invalidate the cache 
(allowing for the reader to do a reverse-msync kind of thing), or do 
they have to read from disk all the time?

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

