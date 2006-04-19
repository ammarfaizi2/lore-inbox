Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWDSRuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWDSRuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWDSRuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:50:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18058 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751015AbWDSRuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:50:54 -0400
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
References: <20060407095132.455784000@sergelap>
	<20060407183600.E40C119B902@sergelap.hallyn.com>
	<4446547B.4080206@sw.ru>
	<20060419152129.GA14756@sergelap.austin.ibm.com>
	<m1bquxmuk5.fsf@ebiederm.dsl.xmission.com>
	<1145463814.31812.13.camel@localhost.localdomain>
	<m1u08pld7d.fsf@ebiederm.dsl.xmission.com>
	<1145467159.31812.21.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 19 Apr 2006 11:48:47 -0600
In-Reply-To: <1145467159.31812.21.camel@localhost.localdomain> (Dave
 Hansen's message of "Wed, 19 Apr 2006 10:19:18 -0700")
Message-ID: <m1r73tjw1s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Wed, 2006-04-19 at 10:52 -0600, Eric W. Biederman wrote:
>> Dave Hansen <haveblue@us.ibm.com> writes:
>> 
>> > Besides ipc and utsnames, can anybody think of some other things in
>> > sysctl that we really need to virtualize?
>> 
>> All of the networking entries.
> ...
>> Only in that you attacked the wrong piece of the puzzle.
>> The strategy table entries simply need to die, or be rewritten
>> to use the appropriate proc entries.
>
> If we are limited to ipc, utsname, and network, I'd be worried trying to
> justify _too_ much infrastructure.  The network namespaces are not going
> to be solved any time soon.  Why not have something like this which is a
> quite simple, understandable, minor hack?

As for the network namespaces.  It actually isn't that hard, but
it is tedious and big.   Once we get ipc and uts it will probably be
the namespace to merge.  I have the basic code sitting out on a branch.
Getting the little things like sysctl, sorted out are the primary
problems.  At the same time we don't have to solve the problems for
the network namespace now.  Just don't expect it way of in the
indefinite future, either.

Eric
