Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271843AbTHHTGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271824AbTHHTGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:06:23 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:6044 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S271843AbTHHTFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 15:05:30 -0400
Message-ID: <3F33F45E.3030706@redhat.com>
Date: Fri, 08 Aug 2003 12:05:02 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030731 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Cusack <fcusack@fcusack.com>
CC: lkml <linux-kernel@vger.kernel.org>, phil-list@redhat.com
Subject: Re: NPTL v userland v LT (RH9+custom kernel problem)
References: <20030807013930.A26426@google.com> <20030808103745.B30702@google.com>
In-Reply-To: <20030808103745.B30702@google.com>
X-Enigmail-Version: 0.81.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Frank Cusack wrote:

> Even without pam_ldap, I see it getting stuck.  'groups: files ldap' in
> nsswitch.conf sets it off.  Here's an sshd that's hung, does this light
> the a-ha bulb for anyone?
> 
> (gdb) bt
> #0  0x40564845 in __pthread_sigsuspend () from /lib/i686/libpthread.so.0
> #1  0x40564318 in __pthread_wait_for_restart_signal ()
>    from /lib/i686/libpthread.so.0
> #2  0x40565d30 in __pthread_alt_lock () from /lib/i686/libpthread.so.0

This has nothing to do with NPTL as you can clearly see from the file
names and the functions used to implement locking.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/M/Re2ijCOnn/RHQRAinJAJ98U1aBMe6CNNS92MQhv+Y8Qcs01wCdG3H2
M2n00ZHMbZpFnrDNyezDYcg=
=T8u5
-----END PGP SIGNATURE-----

