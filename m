Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161106AbWBTSTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWBTSTe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbWBTSTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:19:34 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:32726 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161106AbWBTSTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:19:32 -0500
Subject: Re: (pspace,pid) vs true pid virtualization
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
In-Reply-To: <43F991DC.8010509@sw.ru>
References: <20060215145942.GA9274@sergelap.austin.ibm.com>
	 <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
	 <20060216143030.GA27585@MAIL.13thfloor.at>
	 <20060216153729.GB22358@sergelap.austin.ibm.com>  <43F991DC.8010509@sw.ru>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 10:19:26 -0800
Message-Id: <1140459566.10909.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 12:54 +0300, Kirill Korotaev wrote:
> VPS has reached it's process limit and you can't enter it.
> If you suggest to make enter without resource limitations, then it will 
> be a security hole.

I think the question is:

	Can or should an administrative process be able to do things
	inside of a container, without being subject that that
	container's resource limitations?

Implementation wise, I'm sure we _can_ do something like that.  We
simply have to make sure that when processes are entering containers,
they are subject to the originating container's resource limits, not the
destination.

Could you explain why this is a security hole?

-- Dave

