Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWGLDes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWGLDes (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWGLDes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:34:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13737 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932365AbWGLDer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:34:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kirill Korotaev <dev@sw.ru>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<44B3D435.8090706@sw.ru>
Date: Tue, 11 Jul 2006 21:33:14 -0600
In-Reply-To: <44B3D435.8090706@sw.ru> (Kirill Korotaev's message of "Tue, 11
	Jul 2006 20:39:17 +0400")
Message-ID: <m1k66jebut.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> Another example of not so evident coupling here:
> user structure maintains number of processes/opened files/sigpending/locked_shm
> etc.
> if a single user can belong to different proccess/ipc/... namespaces
> all these becomes unusable.

Why do the count of the number of objects a user has become
unusable if they can count objects in multiple namespaces?

Namespaces are about how names are looked up and how names are
created.  Namespaces are not about the objects those names refer to.

Eric

