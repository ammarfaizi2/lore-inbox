Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWCXRUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWCXRUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 12:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWCXRUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 12:20:21 -0500
Received: from mail.sw-soft.com ([69.64.46.34]:33714 "EHLO mail.sw-soft.com")
	by vger.kernel.org with ESMTP id S1750757AbWCXRUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 12:20:20 -0500
Message-ID: <44242A3F.1010307@sw.ru>
Date: Fri, 24 Mar 2006 20:19:59 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: [RFC] Virtualization steps
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Do-Not-Rej: Toldya
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric, Herbert,

I think it is quite clear, that without some agreement on all these 
virtualization issues, we won't be able to commit anything good to 
mainstream. My idea is to gather our efforts to get consensus on most 
clean parts of code first and commit them one by one.

The proposal is quite simple. We have 4 parties in this conversation 
(maybe more?): IBM guys, OpenVZ, VServer and Eric Biederman. We discuss 
the areas which should be considered step by step. Send patches for each 
area, discuss, come to some agreement and all 4 parties Sign-Off the 
patch. After that it goes to Andrew/Linus. Worth trying?

So far, (correct me if I'm wrong) we concluded that some people don't 
want containers as a whole, but want some subsystem namespaces. I 
suppose for people who care about containers only it doesn't matter, so 
we can proceed with namespaces, yeah?

So the most easy namespaces to discuss I see:
- utsname
- sys IPC
- network virtualization
- netfilter virtualization

all these were discussed already somehow and looks like there is no 
fundamental differencies in our approaches (at least OpenVZ and Eric, 
for sure).

Right now, I suggest to concentrate on first 2 namespaces - utsname and 
sysvipc. They are small enough and easy. Lets consider them without 
sysctl/proc issues, as those can be resolved later. I sent the patches 
for these 2 namespaces to all of you. I really hope for some _good_ 
critics, so we could work it out quickly.

Thanks,
Kirill

