Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWBTO0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWBTO0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWBTO0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:26:00 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:18516 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964921AbWBTOZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:25:59 -0500
Message-ID: <43F9D185.8020906@sw.ru>
Date: Mon, 20 Feb 2006 17:26:13 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Hubertus Franke <frankeh@watson.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
Subject: Re: The issues for agreeing on a virtualization/namespaces implementation.
References: <43E7C65F.3050609@openvz.org> <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com> <20060207201908.GJ6931@sergelap.austin.ibm.com> <43E90716.4020208@watson.ibm.com> <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com> <43E92EDC.8040603@watson.ibm.com> <43F9B1F4.4040907@sw.ru> <20060220124103.GB17478@MAIL.13thfloor.at>
In-Reply-To: <20060220124103.GB17478@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> as does Linux-VServer currently, but do you have
> any proof that putting all the fields together in
> one big structure actually has any (dis)advantage
> over separate structures?
have no proof and don't mind if there are many pointers. Though this 
doesn't look helpful to me as well.

>>mmm, how do you plan to pass additional flags to clone()?
>>e.g. strong or weak isolation of pids?
> do you really have to pass them at clone() time?
> would shortly after be more than enough?
> what if you want to change those properties later?
I don't think it is always suiatable to do configuration later.
We had races in OpenVZ on VPS create/stop against exec/enter etc. (even 
introduced flag is_running). So I have some experience to believe it 
will be painfull place.

>>this syscalls will start handling this new namespace and that's all.
>>this is not different from many syscalls approach.
> well, let's defer the 'how amny syscalls' issue to
> a later time, when we know what we want to implement :)
agreed.

Kirill


