Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWBHVWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWBHVWU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWBHVWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:22:19 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:29602 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965014AbWBHVWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:22:17 -0500
Date: Wed, 8 Feb 2006 15:22:12 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Vilain <sam@vilain.net>, Rik van Riel <riel@redhat.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clg@fr.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org, kuznet@ms2.inr.ac.ru, saw@sawoct.com,
       devel@openvz.org, Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces implementation.
Message-ID: <20060208212212.GA6696@sergelap.austin.ibm.com>
References: <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com> <20060207201908.GJ6931@sergelap.austin.ibm.com> <43E90716.4020208@watson.ibm.com> <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com> <43E92EDC.8040603@watson.ibm.com> <m1ek2ea0fw.fsf@ebiederm.dsl.xmission.com> <43EA02D6.30208@watson.ibm.com> <20060208180309.GA20418@sergelap.austin.ibm.com> <1139430099.9452.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139430099.9452.41.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dave Hansen (haveblue@us.ibm.com):
> On Wed, 2006-02-08 at 12:03 -0600, Serge E. Hallyn wrote:
> > Now I believe Eric's code so far would make it so that you can only
> > refer to a namespace from it's *creating* context.  Still restrictive,
> > but seems acceptable.
> 
> The same goes for filesystem namespaces.  You can't see into random
> namespaces, just the ones underneath your own.  Sounds really reasonable
> to me.

Hmmm?  I suspect I'm misreading what you're saying, but to be clear:

Let's say I start a screen session.  In one of those shells, I clone,
specify CLONE_NEWNS, and exec a shell.  now i do a bunch of mounting.
Other shells in the screen session won't see the results of those
mounts, and if i ctrl-d, the shell which started the screen session
can't either.  Each of these is in the "parent filesystem namespace".

OTOH, shared subtrees specified in the parent shell could make it such
that the parent ns, but not others, see the results.  Is that what
you're referring to?

thanks,
-serge
