Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTENN5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTENN4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:56:16 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:61115 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S262249AbTENNzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:55:54 -0400
Date: Wed, 14 May 2003 10:06:27 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.]
In-Reply-To: <Pine.LNX.4.44.0305141445290.12748-100000@marcellos.corky.net>
Message-ID: <Pine.LNX.4.33.0305141002500.10993-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 May 2003, Yoav Weiss wrote:

>
> Thats a good question.  I see three options:
> 1. Dump the core plaintext.  (sucks but convenient for users).
> 2. In the core, zero the pages that would be encrypted when swapped out.
>    On some policies where only things like keys are encrypted, the core
>    will be usable.  On others it won't.  (Not sure its really an option).
> 3. If the core contains pages that should be encrypted, dump it encrypted
>    with some system-wide (or per-uid) key generated on the first core
>    dump.  The key will be available to the user via some /proc interface.
>    Its up to the user to be smart and take the core to another host and
>    decrypt_core(1) it there (or just decrypt_core(1) it to an encrypted
>    filesystem).  In any case, the decrypted core or the system-wide key
>    are never written to disk.
> 4. Refuse to dump core of a process that has pages that should be
>    encrypted.
>
> Do you see more options ?
> Anyway, it should probably be policy controlled.

These are all very good options, ofcourse things get hairy don't they :)
Perhaps in the beginning either 1, 2 and 4 as per a system wide dump
policy. May be even a setrlimit extension and use that as a jump point to
make a per user policy?

Cheers,

Ahmed.

