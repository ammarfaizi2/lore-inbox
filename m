Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWBFIwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWBFIwA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWBFIwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:52:00 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:47965 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750779AbWBFIv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:51:59 -0500
Message-ID: <43E70E86.9080908@sw.ru>
Date: Mon, 06 Feb 2006 11:53:26 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org
Subject: Re: [RFC][PATCH 3/5] Virtualization/containers: UTSNAME
References: <43E38BD1.4070707@openvz.org> <43E38DA9.9040606@sw.ru> <m1r76guccm.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1r76guccm.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am disturbed by the introduction of #defines like current_vps() and
> vps_utsname.
> 
> Magic lower case #defines are usually a bad idea.  
It is not magic defines, this is done intentionally.
You can take a more detailed view into OpenVZ sources, but the idea is 
to make kernel compilable without virtualization.
When virtualization is OFF all this macros are defined to trivial 
variables/defines which make it an old good kernel.

For example current_vps() should be (&init_vps), i.e. host system 
environment only.

vps_utsname will be defined as system_utsname and so on.

> These defines hide the cost of the operations you are performing.
> At that point you might as well name the thing system_utsname
> so you don't have to change the code.  
You mean to have variable and define with the same names?
it is not always good. It works fine, when both are defined in the same 
file, but poorly when it is scattered all around...

> And of course you failed to change several references to
> system_utsname.
which one? Maybe intentionally? ;-)
Kirill






