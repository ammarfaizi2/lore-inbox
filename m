Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWBMVbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWBMVbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWBMVbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:31:42 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:61080 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030195AbWBMVbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:31:41 -0500
Date: Mon, 13 Feb 2006 15:31:36 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
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
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process id namespace
Message-ID: <20060213213136.GA25799@sergelap.austin.ibm.com>
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com> <m1vevsmgvz.fsf@ebiederm.dsl.xmission.com> <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com> <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com> <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru> <m1wtg2w41c.fsf@ebiederm.dsl.xmission.com> <43F04B28.9090300@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F04B28.9090300@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kirill Korotaev (dev@sw.ru):
> >So far you have not addressed the issues of maintaining code in the
> >kernel tree.  

> Uhhh... I see that you have no real arguments. Nice.

Au contraire, this is a central issue which you have yet to address.
How do you suggest helping maintainers in the future know which pid they
are working with?

For our vpid patchset we had considered using sparse to make sure that
the real ('kernel') and user ('virtual') pids were never used in place
of each other without going through a conversion.  That could be one
solution.  Using opaque typedefs is of course another solution.  But
suspect there will be places in the code where it simply isn't clear
at first glance which pid you'd want.  And if it's not clear at first
glance, then it's likely to be done wrong in at least some of those
places.

-serge
