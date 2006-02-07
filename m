Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWBGTqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWBGTqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 14:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWBGTqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 14:46:15 -0500
Received: from [202.131.75.34] ([202.131.75.34]:41697 "EHLO
	mail.shaolinmicro.com") by vger.kernel.org with ESMTP
	id S964859AbWBGTqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 14:46:14 -0500
Message-ID: <43E8F8EB.8010800@shaolinmicro.com>
Date: Wed, 08 Feb 2006 03:45:47 +0800
From: David Chow <davidchow@shaolinmicro.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
References: <20060207044204.8908.qmail@science.horizon.com> <m1zml3rvkg.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1zml3rvkg.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

First of all, thanks for giving me lots of wonderful feedbacks, I read 
both pros and cons, support and against msgs. And you are right, I am 
serious person about this matter, not joking. Because I do this for my 
bread and butter, not just for fun.

Before I continue this discussion, I would really want to clarify who am 
I before get discriminated by end-users and developers, because I am both.

I am a full-time (M$_less) Linux user (many years...., Sharp Zaurus PDA, 
Linux on laptop, desktop, server, storage and datacenter) with zero 
windows experience for the last 5 years (can't remember, my last windows 
desktop was on NT 4.0/Win98). I am an engineer, I wrote many file 
systems (cogofs http://www.shaolinmicro.com/product/cogofs/, unionfs, 
.....more), cluster infrastructure (used in ShaoLin InfiniCluster 
http://www.shaolinmicro.com/product/icluster/technology.php), data 
replication (used in Shaolin Volume Replicator), load balancing, iSCSI 
storage drivers.....  . I am also a system architect/engineering 
manager, architect core Linux system software from scratch, desktop, 
network computing, servers, network related projects. I am also a R&D 
team manager, hiring, training, manage engineers .

In fact, this is not to talk about myself, but my full-time Linux 
experience tells me Linux development is walking away with end-uesrs and 
commercial developers that try to work with Linux. It sounds too scary 
by now, with over 40MB tarred gzip kernel source. With personal efforts 
and company resources, we maintain more than hundreds (probably 
thousand) of Linux kernel headers and sources in our lab for building 
off-the-shelf supported binary drivers with multiple hardware archs 
(x86, ppc...). Because of this, who is going to pay for this? It doesn't 
make any sense for anyone who want to maintain and write a driver for 
Linux have to pay this price.

My summary from the responses from lkml collected as follows. Please 
feel free to make correction if I am wrong, or comment if you want, I 
will minimize to say about subjective comment to others comment in an 
open area though.

Community Developers and Maintainers:
- Look at the matter on community development process, programming
- Chase for performance, optimization in source level, even though it is 
difficult to maintain, who cares?
- Want freedom, change at will (with supported arguments, but who cares?) .
- My feels like it doesn't consider any other forms of development and 
respect to traditional software engineering or QA process. Because a 
stable API is first needed for teamwork collaborative development.
- Willing to maintain and develop drivers for free, even though they 
don't work for the hardware vendor.
- We will follow the convention who make changes to the API will have to 
patch all the mess in the kernel source, even though there are 3,714,234 
hardware peripheral drivers in the kernel in year 2012, I am happy to do 
that :) . Because I want to make change and following the convention. 
(how much time to make change or test?)

Technical End-Users:
- Want to compile the drivers from source
- Enjoy building their own kernel, apply patches (patch and make, it 
works! thats cool....)
- I don't mind to search for drivers and do it myself, because it was 
fun to make something work with my effort :) .
- I don't mind to upgrade my OS because of a missing driver or needed 
for new fucntionality. Even my application breaks, down time is not 
important to my system because it s a sytsem for fun.

Non-technical Users:
- Want the system to have drivers pre-built, so that they don't have to 
go through a compilation or patching process. Its a waste of time for 
them (waste of time for me too)
- Why I have to search the drivers? Isn't is suppose to be included in 
the OS? Or if not included in the OS, it should be included in a driver 
disk (CD/DVD/floppy or whatever medium or download) .
- Why I have to upgrade the complete OS if only one driver is missing? I 
want to stay with Redhat-9 , my PHP runs great.
- There is no "Linux support" labels on most the hardware out there, 
should I risk my money, buy it and try out? Oh, full refund of item is 
not allowed . Then, don't bother ...

Commercial developers:
- Want a stable API so that drivers can be maintained with ease. Because 
we don't just work with Linux, we want to focus on our driver 
development, not chasing the API changes, versions by versions, vendors 
by vendors. Sometimes there are even vendor specific changes, its a 
waste of time.
- If I have to make binary drivers, I have to maintain all kernel 
sources and headers, compilers to make sure my drivers will be built 
correctly without problem. Of risk to change symbols in the binaries and 
hope it works!
- Where is the latest up-to-date documentation of the kernel API? 
/Documentation only partially describe what I need, its version 
specific, sometimes out-of-date, where the hell is that? Let's google it 
in amazon.com, "Linux driver books", No good again.... Its crap, all not 
up-to-date!
- Lets get on to it, read all docs and sample sources... mmm... My 
driver seems working now.. Lets compile it and distribute it. Users: 
have you got a driver for Redhat 9 2.4.18 kernel? Answer: No, it doesn't 
work, because I write my driver on 2.6.15, you may to DIY. User 
response: I want a refund, because you said your hardware has Linux 
support, but its a false statement.
- Just leave Linux, who cares, it doens't make sense to us. Because it 
doesn't make sense to go through all these problems to say "Linux 
supported hardware", user will get refund the product if we say this on 
the box on day one.
- Maybe we have another way to do that, submit the driver to the 
community and hope it to include it in the latest kernel source. 
Wait.... but what about support for Redhat 9 and SuSe 8.2?
- We are happy to maintain our own drivers, because we know better about 
our hardware. We are paid to do so, we also have quality assurance 
process with formal test tools and equipment. Don't think the community 
can do a better core than us.
- It just doesn't work for us. No more Linux driver Cd's, it will not 
happen .

My comments:
- Freedom? Someone tell me to shut-up . Some people define freedom using 
their own way, not even using mailling list for discussion and make 
suggetions or even define questions as "stupid", I will not say that to 
anyone. Its rude.
- Wake up! Why would the maintainers bother to maintain the drivers if 
the driver development work is now back to the hardware vendor, like 
drivers for other platform did? I think someone mis-understood the whole 
idea is to "GET RID OF DRIVER MAINTENANCE", belive it or not, it belongs 
to the vendor, not here. If the driver releases as GPL, you can still 
make your own changes, but it doesn't have to be in main source tree.
- You plug-in the hardware, it worked! Because many people behind the 
scene has done a lot of work. My purpose of raising this question is 
trying to help both users and developers, and try to make more hardware 
that behaves "plug-n-play" .
- What is the goal of Linux developers? Just for fun? Or you want Linux 
to get more popular? Users want their system to get supported with 
latest drivers, not to compile and build to latest kernel. Or not to 
upgrade their Linux distro every week or month. I don't use 2.6.15 nor 
happy downloading 40Mb targged gzip kernel source and knowing how to 
"make" it.
- Linux will not sail to major desktop unless a decent DDK (driver 
development kit) exists. There is a stable ABI on the user space, but 
the hardware has to "get worked" before anything in user space happens. 
I decide to sell my USB wireless-G adapter because I don't have a driver 
for it, neither Linksys did. I can only choose to get rid of Linux, but 
can't, so just sell it. For others, why don't they simply choose another 
supported OS?
- /Documentation/stable_api_nonsense.txt is only a document totally 
written by a programmer sense, its nothing about people who don't want 
to compile the drivers, and has assumed drivers should be maintained by 
the community. But strictly speaking, it shouldn't. Please refer to the 
process of making a driver from a manufacturers point of view and 
consider user using old OS'es which don't want to upgrade.

Final comment: There is no right or wrong, stupid or smart, it depends 
where you stands and where you want Linux to go. I am very clear myself 
is to get Linux promoted to public sectors (where I belive 99% users are 
non-technical), easy for developers (I believe everyone wants 
easy-way-out) and easy for the community (I belive you people like 
innovation, new ideas, rather thatn spend your time to work/maintain 
drivers which this work should belongs to the original vendor). If you 
think I have no contribution and stupid, that's up to you (who cares? 
Linux has been working like this in day-one that I first compile and run 
it). But my work has already beyond programming, because making patches 
for Linux doesn't make any sense to me, especially when porting drivers 
that I can't even tell what they are. My mood of patching the kernel 
goes away when today's Linux kernel targged gzip source gets to over 
40MB .. I have more important things to do. Its enough for me by now.... 
Sure its not going to change, maybe but not in a year or two, but 
freedom of speech exists, right?

regards,
David Chow
