Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbTGGVF4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 17:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264407AbTGGVF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 17:05:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40713 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264085AbTGGVFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 17:05:55 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: epoll vs stdin/stdout
Date: 7 Jul 2003 14:20:09 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <beco69$rfr$1@cesium.transmeta.com>
References: <20030707154823.GA8696@srv.foo21.com> <20030707194736.GF9328@srv.foo21.com> <20030707200315.GA10939@mail.jlokier.co.uk> <beckj5$e2a$1@news.cistron.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <beckj5$e2a$1@news.cistron.nl>
By author:    "Miquel van Smoorenburg" <miquels@cistron.nl>
In newsgroup: linux.dev.kernel
>
> In article <20030707200315.GA10939@mail.jlokier.co.uk>,
> Jamie Lokier  <jamie@shareable.org> wrote:
> >Unfortunately I cannot think of a way for a process to know, in
> >general, whether two fds that it is passed correspond to the same file
> >*.  Well, apart from trying epoll on it and seeing what happens :/
> 
> fstat() and compare st_dev and st_ino
> 

That doesn't show if they share the same file *.  Two fd's can be open
to the same file or other object without sharing the same file *.

Seriously, this is not something userspace should have to worry
about.  The interface should handle it, otherwise it's broken.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
