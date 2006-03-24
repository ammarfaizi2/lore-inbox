Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWCXVQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWCXVQd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 16:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWCXVQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 16:16:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46553 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750820AbWCXVQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 16:16:32 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Kirill Korotaev <dev@sw.ru>, Dave Hansen <haveblue@us.ibm.com>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       OpenVZ developers list <dev@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
References: <20060321061333.27638.63963.stgit@localhost.localdomain>
	<1142967011.10906.185.camel@localhost.localdomain>
	<m1k6anq8uq.fsf@ebiederm.dsl.xmission.com> <44241224.9000200@sw.ru>
	<m13bh7io3i.fsf@ebiederm.dsl.xmission.com>
	<20060324210150.GA22308@MAIL.13thfloor.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Mar 2006 14:13:40 -0700
In-Reply-To: <20060324210150.GA22308@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Fri, 24 Mar 2006 22:01:50 +0100")
Message-ID: <m1u09nh7gb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> hmm, isn't per process a little extreme ... I know
> what you want to accomplish but won't this lead to
> a per process procfs? 

Where all of the values vary per process possibly, that
is they way /proc is supposed to be.

/proc/sys is the only case that I think really gets extreme.
For things like /proc/sysvipc and /proc/net it really is a natural
break, and /proc/mounts already shows that the technique works fine.

So I am trying to turn an ugly design choice into feature :)

> and, if you want to do per
> process procfs, what would be the gain?
>
> just my opinion ...

Under the covers the implementation is per namespace, but
it isn't easy to export it that way from procfs.

In any event this appears to be a way to implement these things
while retaining backwards compatibility, with the current implementation,
and it looks like it can be implemented fairly cleanly.

Eric
