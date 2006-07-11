Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWGKUYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWGKUYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWGKUYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:24:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9152 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751285AbWGKUYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:24:01 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
References: <20060711075051.382004000@localhost.localdomain>
Date: Tue, 11 Jul 2006 14:22:34 -0600
In-Reply-To: <20060711075051.382004000@localhost.localdomain> (Cedric Le
	Goater's message of "Tue, 11 Jul 2006 09:50:51 +0200")
Message-ID: <m164i3gad1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> Hello !
>
> The following patchset adds the user namespace and a new syscall execns.
>
> The user namespace will allow a process to unshare its user_struct table,
> resetting at the same time its own user_struct and all the associated
> accounting.
>
> The purpose of execns is to make sure that a process unsharing a namespace
> is free from any reference in the previous namespace. the execve() semantic
> seems to be the best candidate as it already flushes the previous process
> context.
>
> Thanks for reviewing, sharing, flaming !


I haven't had a chance to do a thorough review yet but why is
this needed?

What can be left shared by switching to a new namespace and then
execing an executable?

Is it not possible to ensure what you are trying to ensure with
a good user space executable?

Eric
