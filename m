Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWGMUDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWGMUDs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWGMUDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:03:48 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:25535 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030343AbWGMUDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:03:48 -0400
Subject: Re: [PATCH -mm 5/7] add user namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
References: <20060711075051.382004000@localhost.localdomain>
	 <20060711075420.937831000@localhost.localdomain>
	 <m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com> <44B50088.1010103@fr.ibm.com>
	 <m1psgaag7y.fsf@ebiederm.dsl.xmission.com> <44B684A5.2040008@fr.ibm.com>
	 <20060713174721.GA21399@sergelap.austin.ibm.com>
	 <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	 <1152815391.7650.58.camel@localhost.localdomain>
	 <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 13:03:31 -0700
Message-Id: <1152821011.24925.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 13:02 -0600, Eric W. Biederman wrote:
> All comparisons of a user equality need to be of the tuple (user namespace, user id).
> Any comparison that does not do that is an optimization.
...
> So my impression was that Cedric's patchset was overoptimized because
> it did not change most of the uid comparisons, to (user namespace, user id).

I might just be tempted to call them bugs so people understand what I'm
talking about ;)

> Because you can have access to files created in another user namespace it
> is very unlikely that optimization will apply very frequently.  The easy scenario
> to get access to a file descriptor from another context is to consider unix
> domain sockets.

OK, so you're saying that the lack of checks will cause problems rarely,
and that passing a fd across a unix domain sockets is one of the times
when you _could_ encounter this problem?

-- Dave

