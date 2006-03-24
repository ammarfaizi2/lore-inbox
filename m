Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbWCXTfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbWCXTfn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWCXTfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:35:42 -0500
Received: from mail.sw-soft.com ([69.64.46.34]:28349 "EHLO mail.sw-soft.com")
	by vger.kernel.org with ESMTP id S932620AbWCXTfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:35:42 -0500
Message-ID: <442449F8.4050808@sw.ru>
Date: Fri, 24 Mar 2006 22:35:20 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, devel@openvz.org, serue@us.ibm.com,
       sam@vilain.net
Subject: Re: [RFC][PATCH 1/2] Virtualization of UTS
References: <44242B1B.1080909@sw.ru> <44242CE7.3030905@sw.ru> <m18xqzk6cy.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m18xqzk6cy.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Do-Not-Rej: Toldya
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This patch introduces utsname namespace in system, which allows to have
>> different utsnames on the host.
>> Introduces config option CONFIG_UTS_NS and uts_namespace structure for this.
> 
> Ok.  It looks like we need to resolve the sysctl issues before we merge
> either patch, into the stable kernel.
I disagree with you. Right now we can have sysctl and proc for init 
namespaces only.
And when sysctl and proc are virtualized somehow, we can fix all these.
I simply don't expect /proc and sysctl to be done quickly. As we have 
very different approaches. And there is no any consensus. Why not to 
commit working/agreed parts then?

> We also need to discuss the system call interface, as without one
> the functionality is unusable :)
I also don't see why it can be separated. There is an API in namespaces, 
and how it is mapped into syscalls is another question. At least it 
doesn't prevent us from commiting virtualization itself, agree?

Thanks,
Kirill
