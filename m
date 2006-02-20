Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWBTOd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWBTOd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWBTOd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:33:56 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:56327 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030248AbWBTOdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:33:55 -0500
Message-ID: <43F9D379.5000803@sw.ru>
Date: Mon, 20 Feb 2006 17:34:33 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: (pspace,pid) vs true pid virtualization
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216142928.GA22358@sergelap.austin.ibm.com> <43F98DD5.40107@sw.ru> <20060220124745.GC17478@MAIL.13thfloor.at>
In-Reply-To: <20060220124745.GC17478@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>yes, acceptable.
>>once, again, believe me, this is very required feature for
>>troubleshouting and management (as Eric likes to take about
>>maintanance :) )

> IMHO there are certain things which _are_ required
> and others which are nice to have but not strictly
> required, just think "ptrace across pid spaces"
these "nice to have" features often make one solution more usable than 
another.

>>>This is to support using pidspaces for vservers, and creating
>>>migrateable sub-pidspaces in each vserver.
>>
>>this doesn't help to create migratable sub-pidspaces.
>>for example, will you share IPCs in your pid parent and child pspaces?
>>if yes, then it won't be migratable;
> well, not the child pspace, but the parent, no?
if IPC objects are shared between them, then they can only be migrated 
together.

>>if no, then you need to create fully isolated spaces to the end and
>>again you end up with a question, why nested pspaces are required at
>>all?
> because we are not trying to implement a VPS only
> solution for mainline, we are trying to provide
> building blocks for many different uses, including
> the VPS approach ...
nice! do you think I'm against building blocks?
no :) I'm just trying to get out from you how this can be used in real 
life and how will it work.

Kirill

