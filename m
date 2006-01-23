Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWAWV57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWAWV57 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWAWV57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:57:59 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:9135 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932226AbWAWV56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:57:58 -0500
Subject: Re: RFC: [PATCH] pids as weak references.
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>,
       Vserver <vserver@list.linux-vserver.org>
In-Reply-To: <m1k6cqlmfe.fsf_-_@ebiederm.dsl.xmission.com>
References: <20060117143258.150807000@sergelap>
	 <20060117143326.283450000@sergelap>
	 <1137511972.3005.33.camel@laptopd505.fenrus.org>
	 <20060117155600.GF20632@sergelap.austin.ibm.com>
	 <1137513818.14135.23.camel@localhost.localdomain>
	 <1137518714.5526.8.camel@localhost.localdomain>
	 <20060118045518.GB7292@kroah.com>
	 <1137601395.7850.9.camel@localhost.localdomain>
	 <m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	 <43D14578.6060801@watson.ibm.com>
	 <m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
	 <43D52592.8080709@watson.ibm.com>
	 <m1k6cqlmfe.fsf_-_@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 13:57:54 -0800
Message-Id: <1138053474.12259.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 13:27 -0700, Eric W. Biederman wrote:
> So currently I can see to justifications for introducing
> a separation between kpid_t pid_t.
> 1) pid virtualization
> 2) In kernel pids that act as weak references, and avoid
>    the problems of pid wrap-around.

It is an interesting approach.  But, in its current state, it is very,
very hard to review.  For starters, could you break it up so that the
meat of the patch is separate from the easy
s/foo->pid/pid_nr(foo->pid)/ stuff?

-- Dave

