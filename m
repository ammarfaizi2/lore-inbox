Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268115AbUIPTIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268115AbUIPTIN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 15:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268138AbUIPTIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 15:08:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24752 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268115AbUIPTIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 15:08:07 -0400
Message-ID: <4149E46E.7010804@redhat.com>
Date: Thu, 16 Sep 2004 12:07:26 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Utz Lehmann <lkml@de.tecosim.com>
CC: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flexmmap: optimise mmap_base gap for hard limited stack
References: <20040916165613.GA10825@de.tecosim.com> <20040916174529.GA16439@devserv.devel.redhat.com> <20040916182139.GA21870@de.tecosim.com>
In-Reply-To: <20040916182139.GA21870@de.tecosim.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Utz Lehmann wrote:

> A check for CAP_SYS_RESOURCE can be added. But i dont think it's worth.

It is needed.  Otherwise how do you allow increasing the stack size
again once it has been limited?  I've no problem with using the smallest
reserved stack region with !CAP_SYS_RESOURCE, but otherwise the existing
method should be used.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBSeRu2ijCOnn/RHQRAi9kAKCvg6KSntcpjNT0Ld8wLQuS5RqxtACfUwDY
X59x6hGwCtUZUgbX2O/hV7k=
=mOVA
-----END PGP SIGNATURE-----
