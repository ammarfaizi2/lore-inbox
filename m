Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbTHUCh6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 22:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbTHUCh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 22:37:58 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:38123
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262365AbTHUCh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 22:37:56 -0400
Message-ID: <3F443048.6000902@redhat.com>
Date: Wed, 20 Aug 2003 19:36:56 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030731 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: posix_fallocate question again
References: <41F331DBE1178346A6F30D7CF124B24B0183C1A4@fmsmsx409.fm.intel.com> <20030820214643.A5572@infradead.org>
In-Reply-To: <20030820214643.A5572@infradead.org>
X-Enigmail-Version: 0.81.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig wrote:

> Note that the design for posix_fallocate is stupid.  We really want
> a 64bit len argument even on 32bit machines.

I've submitted already a bug report for that.  *Iff* somebody implements
posix_fallocate in the kernel, use

  int posix_fallocate (int, off64_t, off64_t)

as the interface (or whatever the kernel equivalent is).

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/RDBI2ijCOnn/RHQRAkmmAKCeiC4KYsvBDV65wj/GNmPMIw9t6gCgxFSC
EkqBO4PyRhTxqhvz9dlHU08=
=BASe
-----END PGP SIGNATURE-----

