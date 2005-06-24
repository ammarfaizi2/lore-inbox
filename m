Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262958AbVFXINT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbVFXINT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 04:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbVFXINT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 04:13:19 -0400
Received: from [67.137.28.189] ([67.137.28.189]:5266 "EHLO vger")
	by vger.kernel.org with ESMTP id S262958AbVFXIND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 04:13:03 -0400
Message-ID: <42BBABE9.7010300@utah-nac.org>
Date: Fri, 24 Jun 2005 00:44:57 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Beulich <JBeulich@novell.com>
Cc: Christoph Lameter <christoph@lameter.com>,
       Clyde Griffin <CGRIFFIN@novell.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Novell Linux Kernel Debugger (NLKD)
References: <42BBD4A1020000780001D4D1@emea1-mh.id2.novell.com>
In-Reply-To: <42BBD4A1020000780001D4D1@emea1-mh.id2.novell.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Beulich wrote:

>>1. No back trace
>>    
>>
>
>You're the second one to mention this, and I wonder where you take this from.
>  
>
Check the version binaries on NovellForge. Didn't work. Suse Linux perhaps?

>  
>
>>2. Doesn't run standalone fully embeded in the kernel
>>    
>>
>
>What do you mean with 'fully embedded'? As long as the agents aren't compiled as modules, everything's right in the kernel (of course, not the mainline one, but that's same as for kdb and kgdb).
>  
>

Right.

>  
>
>>3. Not fully open source (since it's not embeded in the kernel)
>>    
>>
>
>What has embedding things in the kernel to do with being open source?
>  
>

Debuggers need to be open source to work on Linux (socially work, not 
technically). They also need to use kdb
and gdb as a base, so you can have one patch that runs on all the kdb 
versions for the kernels. Then you can use kdb
and let it do all the interfacing beneath you and leverage KDB and the 
porting effort there. Hook kdb() and traps.c
for events to userspace.


>  
>
>>5. No advanced recursive descent parser for conditional breakpoints
>>    
>>
>
>Where've you seen this? What functionality does the parser miss?
>  
>

Your architecture is event based, but there's no source code to change 
this, just a white paper. How do I know a conditional
breakpoint is running real time when it triggers. No source code, no 
interest.... Social Problem.

There is ****NO**** commerical debugger business on Linux. I don't agree 
that the GPL contaminates most
kernel modules, but a kernel debugger is one exception, because it has 
to include key kernel header files and truly is
an "integrated" component (at least a decent one is).

If you want to promote an interesting project and make no money off of 
it, open source your debugger, put it on KDB
as a base, and lots of folks will use it. We tried the whole kernel 
debugger product thing, and there are actual legal
issues if you choose not to open source it. File Systems, drivers, etc. 
-- not the case. Kernel debugger is the case.

:-)

Jeff


>Jan
>
>
>  
>

