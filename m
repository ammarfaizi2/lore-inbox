Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751995AbWCJS7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbWCJS7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 13:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbWCJS7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 13:59:03 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:62405 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751995AbWCJS7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 13:59:02 -0500
Subject: Re: sysctls inside containers
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com
In-Reply-To: <441152C0.2030501@sw.ru>
References: <43F9E411.1060305@sw.ru>
	 <m1oe0wbfed.fsf@ebiederm.dsl.xmission.com>
	 <1141062132.8697.161.camel@localhost.localdomain>
	 <m1ek1owllf.fsf@ebiederm.dsl.xmission.com>
	 <1141442246.9274.14.camel@localhost.localdomain>  <441152C0.2030501@sw.ru>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 10:58:33 -0800
Message-Id: <1142017113.12453.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 13:19 +0300, Kirill Korotaev wrote:
> > On another note, after messing with putting data in the init_task for
> > these things, I'm a little more convinced that we aren't going to want
> > to clutter up the task_struct with all kinds of containerized resources,
> > _plus_ make all of the interfaces to share or unshare each of those.
> > That global 'struct container' is looking a bit more attractive.
> 
> have you noticed that ipc/mqueue.c uses netlink to send messages?
> This essentially means that they are tied as well...

Nope, I missed that.

But, netlink is probably a completely separate issue, at least for now.
I'm sure we're going to have "container leaks" and boundary violations
for a long time, but I'll add netlink to the list.

-- Dave

