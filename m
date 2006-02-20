Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWBTK0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWBTK0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWBTK0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:26:38 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:14379 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964845AbWBTK0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:26:37 -0500
Message-ID: <43F99586.9050308@sw.ru>
Date: Mon, 20 Feb 2006 13:10:14 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
References: <20060215145942.GA9274@sergelap.austin.ibm.com>	 <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>	 <20060216143030.GA27585@MAIL.13thfloor.at> <1140111692.21383.2.camel@localhost.localdomain>
In-Reply-To: <1140111692.21383.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>this is mandatory, as it is required to kill any process
>>from the host (admin) context, without entering the pid
>>space (which would lead to all kind of security issues) 
> 
> 
> Giving admin processes the ability to enter pid spaces seems like it
> solves an entire class of problems, right?.  Could you explain a bit
> what kinds of security issues it introduces?
Enter is not always possible.
For example when you have exhausted your resources in VPS.
(e.g. hit process limit inside).
And you can't make enter without resource limitations, since it will be 
a security hole then.

Kirill

