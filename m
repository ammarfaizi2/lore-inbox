Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSJQVEC>; Thu, 17 Oct 2002 17:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262022AbSJQVEC>; Thu, 17 Oct 2002 17:04:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23047 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261996AbSJQVEB>;
	Thu, 17 Oct 2002 17:04:01 -0400
Message-ID: <3DAF272B.8040301@pobox.com>
Date: Thu, 17 Oct 2002 17:10:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell Coker <russell@coker.com.au>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
References: <20021017195015.A4747@infradead.org> <20021017201030.GA384@kroah.com> <3DAF1DC8.1090708@pobox.com> <200210172300.05131.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Coker wrote:
> On Thu, 17 Oct 2002 22:30, Jeff Garzik wrote:
> 
>>Greg KH wrote:
>>
>>>Hm, in looking at the SELinux documentation, here's a list of the
>>>syscalls they need:
>>>	http://www.nsa.gov/selinux/docs2.html
>>>
>>>That's a lot of syscalls :)
>>
>>Any idea if security identifiers change with each syscall?
>>
>>If not, a lot of the xxx_secure syscalls could go away...
> 
> 
> None of them can go away.
> 
> Security identifiers are for the operation you perform.  For example 
> open_secure() is so that you can specify the security context for a new file 
> that you are creating.  connect_secure() is used to specify the security 
> context of the socket you want to connect to.  In the default setup the only 
> way that connect_secure() and open_secure() can use the same SID is for unix 
> domain sockets (which are labeled with file types).  A TCP connection will be 
> to a process, the SID of a process is not a valid type label for a file.
> 
> lstat_secure(), recv_secure() and others are used to retrieve the security 
> context of the file, network message, etc.


What specific information differs per-operation, such that security 
identifiers cannot be stored internally inside a file handle?

	Jeff



