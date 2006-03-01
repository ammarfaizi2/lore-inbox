Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWCAWGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWCAWGq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWCAWGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:06:46 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:45620 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751299AbWCAWGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:06:45 -0500
Message-ID: <44061AEA.5040304@fr.ibm.com>
Date: Wed, 01 Mar 2006 23:06:34 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Kirill Korotaev <dev@sw.ru>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process
 id namespace
References: <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru> <m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru> <m1wtfytri1.fsf@ebiederm.dsl.xmission.com> <43F31972.3030902@sw.ru> <20060215133131.GD28677@MAIL.13thfloor.at> <43F9A80A.6050808@sw.ru> <20060220123427.GA17478@MAIL.13thfloor.at> <43F9CE1C.2020603@sw.ru> <20060220150811.GA18841@MAIL.13thfloor.at>
In-Reply-To: <20060220150811.GA18841@MAIL.13thfloor.at>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
>>>>First of all, I don't think syscalls like
>>>>"do_something and exec" should be introduced.
>>>
>>>Linux-VServer does not have any of those syscalls
>>>and it works quite well, so why should we need such
>>>syscalls?
>>
>>My question is the same! Why?
> 
> 
> because we don't need them?!

I think that the reason behind such syscalls is to make sure that the
process is "clean" when it enters a new container. "clean" means that the
process is not holding in memory an identifier, like a pid for instance,
that doesn't make sense in the new container.

This is really a edge case which supposes that processes changing
containers don't know what they are doing. This case also depends on how
identifiers will be virtualized.

C.
