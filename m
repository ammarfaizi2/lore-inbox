Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSDFEO1>; Fri, 5 Apr 2002 23:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313688AbSDFEOR>; Fri, 5 Apr 2002 23:14:17 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:26221 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313687AbSDFEOC>; Fri, 5 Apr 2002 23:14:02 -0500
Date: Fri, 5 Apr 2002 23:13:59 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Tony.P.Lee@nokia.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: mprotect() api overhead.
Message-ID: <20020405231359.A25663@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: <Tony.P.Lee@nokia.com>
> Date: Fri, 22 Mar 2002 22:10:20 PST

> We like to design a software in certain module way.  For example,
> a libForwardTableManager.so for infiniband switch manager 
> might manager 128 MBytes of share memory data.  10 or more 
> applications will call the APIs in the libForwardTableManager.so 
> to get/set the forward table data.
>[...]
> What I like to do is to use the mprotect() api to turn on/off the 
> memory read/write access to the globally share memory.  This
> way, the only possible memory corruption to the share table 
> is from the APIs in the libForwardTableManager.so

Tony, I think you need to rethink your API.
E.g. what does the switch manager do and why did you
decide to keep any data in a shared memory, of all things?
Why do you need several applications to access the
switch forwarding table? Perhaps, if you answer those
questions, you do not need to bang mprotect() so hard
anymore.

-- Pete
