Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbTJHTMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 15:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTJHTMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 15:12:47 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:54960
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261772AbTJHTMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 15:12:45 -0400
Message-ID: <3F846183.9010205@redhat.com>
Date: Wed, 08 Oct 2003 12:12:03 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAwtz+A6aJAkeufXSGK2GIiwEAAAAA@casabyte.com> <Pine.LNX.4.44.0310071743370.32358-100000@home.osdl.org> <20031008104726.GA4655@outpost.ds9a.nl>
In-Reply-To: <20031008104726.GA4655@outpost.ds9a.nl>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

bert hubert wrote:

> I may be missing something, I'm all for the ability to have threads with
> their own fd namespace, but will NPTL/Linux retain the capability to pass
> fd's to other threads?


Grr, somebody should have killed this thread before these pointless,
irritating, and simply wrong arguments were made by the White fella.
Exactly because it's irritating many readers as can be witnessed above.


The kernel thread functionality is not used 1-to-1 in the userlevel
interfaces of the pthread library.  One very specific combination of all
the CLONE_* flags is used in libpthread.  Other users of the kernel
might use other combinations and they won't implement pthreads.  That
is perfectly fine and if it fits your bill, do it.  But none of this
ever has any influence on the pthread interface.  The properties like
sharing of file descriptors are guaranteed.

If somebody insists in future to discuss kernel "thread" related issues,
use the term "clone" instead of "thread".  This will keep the irritation
level down.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/hGGD2ijCOnn/RHQRAv54AJ0XYGVQ1Iawhwm237eULPP4lFeK9ACfSrc2
A8XJuJGBecVfACkEAVPmYrA=
=EGWH
-----END PGP SIGNATURE-----

