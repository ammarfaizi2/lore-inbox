Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWBFT4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWBFT4d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWBFT4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:56:33 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:21211 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932343AbWBFT4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:56:31 -0500
Subject: Re: [RFC][PATCH 03/20] pid: Introduce a generic helper to test for
	init.
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
In-Reply-To: <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	 <m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	 <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	 <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 11:56:11 -0800
Message-Id: <1139255772.6189.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 12:29 -0700, Eric W. Biederman wrote:
> Introduce is_init to capture this case.  
> 
> With multiple pid spaces for all of the cases affected we are looking
> for only the first process on the system, not some other process that
> has pid == 1. 

If we have cases where each container has its own init (like vserver,
right?), will this naming get confusing?  Will we have pseudo-init tasks
as well?

-- Dave

