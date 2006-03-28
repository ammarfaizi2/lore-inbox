Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWC1VfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWC1VfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWC1VfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:35:08 -0500
Received: from s93.xrea.com ([218.216.67.44]:12180 "HELO s93.xrea.com")
	by vger.kernel.org with SMTP id S932163AbWC1VfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:35:07 -0500
Message-Id: <200603282138.AA00929@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
From: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Date: Wed, 29 Mar 2006 06:38:42 +0900
To: devel@openvz.org
Cc: akpm@osdl.org, Nick Piggin <nickpiggin@yahoo.com.au>, sam@vilain.net,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, serue@us.ibm.com,
       herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
In-Reply-To: <4429A17D.2050506@openvz.org>
References: <4429A17D.2050506@openvz.org>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>>2. Folks, how you think about other good points of Xen,
>>   like live migration, or runs solaris, or has suspend/resume or...
>>  
>>
>OpenVZ will have live zero downtime migration and suspend/resume some 
>time next month.
>

COOL!!!! 

>>
>>1. Dont use Xen for running multiple VMs.
>>2. Use Xen for better admin/operation/deploy... tools.
>>  
>>
>This point is controversial. Tools are tools -- they can be made to 
>support Xen, Linux VServer, UML, OpenVZ, VMware -- or even all of them!
>
>But anyway, speaking of tools and better admin operations, what it takes 
>to create a Xen domain (I mean create all those files needed to run a 
>new Xen domain), and how much time it takes? Say, in OpenVZ creation of 
>a VE (Virtual Environment) is a matter of unpacking a ~100MB tarball and 
>copying 1K config file -- which essentially means one can create a VE in 
>a minute. Linux-VServer should be pretty much the same.
>
>Another concern is, yes, manageability. In OpenVZ model the host system 
>can easily access all the VPSs' files, making, say, a mass software 
>update a reality. You can easily change some settings in 100+ VEs very 
>easy. In systems based on Xen and, say, VMware one should log in into 
>each system, one by one, to administer them, which is not unlike the 
>'separate physical server' model.
>
>>3. If you need multiple VMs, use jail on Xen.
>>  
>>
>Indeed, a mixed approach is very interesting. You can run OpenVZ or 
>Linux-VServer in a Xen domain, that makes a lot of sense.
>
>

Sorry for making misunderstanding.
What I wanted to say with "2" (use Xen as a tool) is, probably same as
what you are guessing now.
I mean, you make a server like this.
1. Install jailed Linux(OpenVZ/Vserver/or..) on Xen
2. make only one domU. and many VMs on this domU with jail.
3. runs many (more than 100 or...) VMs with jail, not with Xen.
4. but, for example, you want to migrate to another PC,
   use Xen live migration.
The fourth point would help administration tasks easier. This is the point
where I mentioned about "better tool".
There is other usage of Xen as admin tool. For example, if you need device
driver (e.g. new iSCSI H/W driver or gigabit ether or...) of 2.6 kernel, but
no need to use any other 2.6 funcs, keep guest OS (domU) as 2.4, and make
dom0 as 2.6 Xen.  This also helps admin tasks.
Probably, the biggest problem for now is, Xen patch conflicts with
Vserver/OpenVZ patch.


           --- Okajima, Jun. Tokyo, Japan.
