Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965199AbWBHEhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbWBHEhX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 23:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbWBHEhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 23:37:23 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:9409 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S965199AbWBHEhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 23:37:22 -0500
Date: Wed, 8 Feb 2006 05:37:21 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Hubertus Franke <frankeh@watson.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>
Subject: Re: The issues for agreeing on a virtualization/namespaces implementation.
Message-ID: <20060208043721.GA26692@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	Sam Vilain <sam@vilain.net>, Rik van Riel <riel@redhat.com>,
	Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	clg@fr.ibm.com, haveblue@us.ibm.com, greg@kroah.com,
	alan@lxorguk.ukuu.org.uk, arjan@infradead.org, saw@sawoct.com,
	devel@openvz.org, Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
References: <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com> <20060207201908.GJ6931@sergelap.austin.ibm.com> <43E90716.4020208@watson.ibm.com> <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com> <43E92EDC.8040603@watson.ibm.com> <20060208004325.GA15061@ms2.inr.ac.ru> <m1k6c6bm57.fsf@ebiederm.dsl.xmission.com> <20060208033633.GA8784@sergelap.austin.ibm.com> <m1d5hybj80.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5hybj80.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 08:52:15PM -0700, Eric W. Biederman wrote:
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> >
> > What I tried to do in a proof of concept long ago was to have
> > CLONE_NETNS mean that you get access to all the network devices, but
> > then you could drop/add them.  Conceptually I prefer that to getting an
> > empty namespace, but I'm not sure whether there's any practical use
> > where you'd want that...
> 
> My observation was that the network stack does not come out cleanly
> as a namespace unless you adopt the rule that a network device
> belongs to exactly one network namespace.

yep, that's what the first network virtualization for
Linux-VServer aimed at, but found too complicated
the second one uses 'pairs' of communicating devices
to send between guests/host

> With that rule dealing with the network stack is just a matter of
> making some currently global variables/data structures per container.

yep, like the universal loopback and so ...

> A pain to do the first round but easy to maintain once you are there
> and the logic of the code doesn't need to change.

best,
Herbert

> Eric
