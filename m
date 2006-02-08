Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWBHPfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWBHPfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWBHPfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:35:23 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:926 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030363AbWBHPfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:35:22 -0500
Message-ID: <43EA0FDB.9050008@sw.ru>
Date: Wed, 08 Feb 2006 18:35:55 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Hubertus Franke <frankeh@watson.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Vilain <sam@vilain.net>, Rik van Riel <riel@redhat.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clg@fr.ibm.com, haveblue@us.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org, kuznet@ms2.inr.ac.ru,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces implementation.
References: <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com> <20060207201908.GJ6931@sergelap.austin.ibm.com> <43E90716.4020208@watson.ibm.com> <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com> <43E92EDC.8040603@watson.ibm.com> <m1ek2ea0fw.fsf@ebiederm.dsl.xmission.com> <43EA02D6.30208@watson.ibm.com> <20060208151726.GA28602@sergelap.austin.ibm.com>
In-Reply-To: <20060208151726.GA28602@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Eric W. Biederman wrote:
>>So it seems the clone( flags ) is a reasonable approach to create new
>>namespaces. Question is what is the initial state of each namespace?
>>In pidspace we know we should be creating an empty pidmap !
>>In network, someone suggested creating a loopback device
>>In uts, create "localhost"
>>Are there examples where we rather inherit ?  Filesystem ?
> Of course filesystem is already implemented, and does inheret a full
> copy.

why do we want to use clone()? Just because of its name and flags?
I think it is really strange to fork() to create network context. What 
has process creation has to do with it?

After all these clone()'s are called, some management actions from host 
system are still required, to add these IPs/routings/etc.
So? Why mess it up? Why not create a separate clean interface for 
container management?

Kirill

