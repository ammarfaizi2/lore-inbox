Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264497AbTLCEh5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 23:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTLCEh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 23:37:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:6600 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264497AbTLCEh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 23:37:56 -0500
Date: Tue, 2 Dec 2003 20:37:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eduardo E. Silva" <esilva@silvex.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Red Hat AS 2.1 crash.
In-Reply-To: <45084.12.9.207.208.1070424568.squirrel@24.199.16.170>
Message-ID: <Pine.LNX.4.58.0312022036050.2072@home.osdl.org>
References: <45084.12.9.207.208.1070424568.squirrel@24.199.16.170>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Dec 2003, Eduardo E. Silva wrote:
>
> Hello, while mousing around we ran a command
>
> find / -type f -exec grep pass {} \;
>
> on a Red Hat Advanced Server 2.1 using kernel  2.4.9-e.12smp based rpm from
> Red Hat. Well the machine panic when grep hit /proc/kmsg.

That would be a bug. Although I suspect it's also a case of "don't do that
then" - you _really_ shouldn't indiscriminately touch files in /proc,
since they often have magical properties.

> I ran the same command on a machine with a later kernel  2.4.9-e.30smp
> withour panicing the machine. Although it hung up in the /proc/kmsg.
>
> Has this been a confirmed bug ?

The latter is not a bug, it's just an example of the magical properties of
/proc. Some files may _look_ like regular files, but you shouldn't depend
on it.

		Linus
