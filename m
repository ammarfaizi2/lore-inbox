Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751843AbWF2AUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWF2AUh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbWF2AUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:20:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22976 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751838AbWF2AUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:20:36 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: James Morris <jmorris@namei.org>
Cc: Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       Al Viro <viro@ftp.linux.org.uk>, Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru>
	<m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
	<20060627215859.A20679@castle.nmd.msu.ru>
	<m1ejx9kj1r.fsf@ebiederm.dsl.xmission.com>
	<20060628150605.A29274@castle.nmd.msu.ru>
	<44A2FA66.5070303@fr.ibm.com>
	<Pine.LNX.4.64.0606281851300.16528@d.namei>
Date: Wed, 28 Jun 2006 18:19:05 -0600
In-Reply-To: <Pine.LNX.4.64.0606281851300.16528@d.namei> (James Morris's
	message of "Wed, 28 Jun 2006 18:54:22 -0400 (EDT)")
Message-ID: <m164ikeruu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> writes:

> On Wed, 28 Jun 2006, Daniel Lezcano wrote:
>
>> The attached patch can have some part interesting for you for the socket
>> tagging. It is in the IPV4 isolation (part 5/6). With this and the private
>> routing table you will probably have a good IPV4 isolation.
>
> Please send patches inline, do not attach them.
>
> (Perhaps we should have a filter on vger which drops emails with 
> attachements).
>
> All of this needs to be done in a way where it can be entirely disabled at 
> compile time, so there is zero overhead for people who don't want 
> network namespaces.

I agree with the principle of no overhead.  

The goal is an implementation that has no measurable overhead when
there is only one network namespace. 

If that goal is achieved and you can compile in the network namespace
code and not measure overhead there should be no need for a compile
time option.

Eric
