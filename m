Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbTEJApl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 20:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTEJApl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 20:45:41 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:7062 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S263624AbTEJApk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 20:45:40 -0400
Message-ID: <3EBC4E9A.3090204@redhat.com>
Date: Fri, 09 May 2003 17:58:02 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030506
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Edgar Toernig <froese@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell> <b9gr03$42n$1@cesium.transmeta.com> <3EBC0084.4090809@redhat.com> <3EBC15B5.4070604@zytor.com> <3EBC2164.6050605@redhat.com> <3EBC29A5.1050005@techsource.com> <3EBC2A3C.8040409@redhat.com> <3EBC3167.2030302@techsource.com> <3EBC38C1.6020305@redhat.com> <3EBC4119.B5C8F11A@gmx.de>
In-Reply-To: <3EBC4119.B5C8F11A@gmx.de>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Edgar Toernig wrote:

> Anyway, what's so bad about the idea someone (Linus?) suggested?
> Without MAP_FIXED the address given to mmap is already taken as a
> hint where to start looking for free memory.

The kernel fortunately already defines some semantics to using a
non-NULL first parameter without MAP_FIXED.  It means: I prefer
*exactly* this address.  If it's not available, give me anything else.
This is used and needed, for instance, when loading prelinked DSOs.

Now you want to give this another semantics.  It would need at least one
more MAP_* flag.

Anyway, I don't care what the solution looks like.  Changing existing
semantics should be out, that's the only requirement.  Since I don't
plan on doing the work I have nothing to decide.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+vE6a2ijCOnn/RHQRAnxgAJ9ptrA6XRvLveB+xZyXZVTz4W8KjgCgkyUp
BwOWiMQys/z8b6HZpneawJs=
=Ra9K
-----END PGP SIGNATURE-----

