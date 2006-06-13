Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932794AbWFMCqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932794AbWFMCqD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 22:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWFMCqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 22:46:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14525 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932794AbWFMCqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 22:46:02 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kirill Korotaev <dev@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>, devel@openvz.org, xemul@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       herbert@13thfloor.at, saw@sw.ru, serue@us.ibm.com, sfrench@us.ibm.com,
       sam@vilain.net, haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [PATCH] IPC namespace
References: <44898BF4.4060509@openvz.org>
Date: Mon, 12 Jun 2006 20:44:52 -0600
In-Reply-To: <44898BF4.4060509@openvz.org> (Kirill Korotaev's message of "Fri,
	09 Jun 2006 18:55:48 +0400")
Message-ID: <m1bqsx4vvf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@openvz.org> writes:

> The patches in this thread add IPC namespace functionality
> additionally to already included in -mm tree UTS namespace.
>
> This patch set allows to unshare IPCs and have a private set
> of IPC objects (sem, shm, msg) inside namespace. Basically, it is another
> building block of containers functionality.
>
> Tested with LTP inside namespaces.
>
> Signed-Off-By: Pavel Emelianiov <xemul@openvz.org>
> Signed-Off-By: Kirill Korotaev <dev@openvz.org>
>
> P.S. patches are against linux-2.6.17-rc6-mm1

Minor nit.  These patches are not git-bisect safe.
So if you have to apply them all to get a kernel
that builds.

Anyone trying to narrow down breakage is likely to land
in the middle and hit a compile error.

Eric

