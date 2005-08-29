Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVH2IQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVH2IQi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 04:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVH2IQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 04:16:38 -0400
Received: from [218.25.172.144] ([218.25.172.144]:11526 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1751242AbVH2IQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 04:16:37 -0400
Message-ID: <4312C45D.4050801@fc-cn.com>
Date: Mon, 29 Aug 2005 16:16:29 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org,
       dhommel@gmail.com
Subject: Re: syscall: sys_promote
References: <20050826092537.GA3416@localhost.localdomain>	 <20050826124738.GD28640@harddisk-recovery.com> <4312873F.8060006@fc-cn.com> <1125302028.4882.10.camel@tara.firmix.at>
In-Reply-To: <1125302028.4882.10.camel@tara.firmix.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:

>On Mon, 2005-08-29 at 11:55 +0800, qiyong wrote:
>  
>
>>Erik Mouw wrote:
>>    
>>
>>>On Fri, Aug 26, 2005 at 05:25:37PM +0800, Coywolf Qi Hunt wrote:
>>>      
>>>
>>>>I just wrote a tool with kernel patch, which is to set the uid's of a running
>>>>process without FORK.
>>>>
>>>>The tool is at http://users.freeforge.net/~coywolf/pub/promote/
>>>>Usage: promote <pid> [uid]
>>>>
>>>>I once need such a tool to work together with my admin in order to tune my web
>>>>configuration.  I think it's quite convenient sometimes. 
>>>>
>>>>The situations I can image are:
>>>>
>>>>1) root processes can be set to normal priorities, to serve web
>>>>service for eg.
>>>>        
>>>>
>>>Most (if not all) web servers can be told to drop all privileges and
>>>run as a normal user. If not, you can use selinux to create a policy
>>>for such processes (IIRC that's what Fedora does).
>>>      
>>>
>>In this way, it's that the web servers themselves drop the privileges, 
>>not forced by sysadmin.  sys_promote is a new approach different from 
>>    
>>
>
>The sysadmin selects the tool and writes the configuration file. So for
>the purpose of this discussion, it is effectively the same.
>
>  
>
>>selinux or sudo.  sys_promote is manipulating a already running process, 
>>while selinux or sudo is for the next launching process.
>>    
>>
>
>Kill the process and start it again. Problem solved.
>
>  
>
>>>>2) admins promote trusted users, so they can do some system work without knowing
>>>>  the password
>>>>
>>>>        
>>>>
>>>Use sudo for that, it allows even much finer grained control.
>>>      
>>>
>>sudo may become a security problem.  Sysadmin and the user don't like 
>>    
>>
>
>(almost) every tool may become a security problem.
>If you fear a bug in sudo, then write a minimal setuid wrapper for
>yourself which checks for the user it started and exec's a binary (with
>the full path name specified).
>And even then - dependent on other details of the setup - you have the
>gap of security problems (or misuse) because of holes in the security.
>  
>

But if we make sure a tool doesn't introduce any new secrutiy problem, 
that's good enough.

>  
>
>>the user's account
>>always have priorities.  My sysadmin Hommel says this to me:
>>    
>>
>
>What does the user do if the process terminates (for whatever reason)
>and must be restarted by the user (manually or auutomatically)?
>  
>

If we worry that, we'd make a persistent OS instead.

>Basically I can see no need for "one time in history" actions. A daemon
>can terminate and must be restarted (it may even be a software bug that
>causes this and this doesn't change anything that the daemon's admin
>must restart it *now*). The machine may reboot for whatever reason ....
>  
>

The US space shuttle certainly can auto pilot, so it doesn't need a 
control panel.
And If anything fails, NASA  just launch another ship?


