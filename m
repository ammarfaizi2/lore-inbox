Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbQKFXWK>; Mon, 6 Nov 2000 18:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129608AbQKFXWA>; Mon, 6 Nov 2000 18:22:00 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:32015 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129166AbQKFXVs>;
	Mon, 6 Nov 2000 18:21:48 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011062321.eA6NLON235284@saturn.cs.uml.edu>
Subject: Re: Announce: NFS-client & NIS-client UID/GID remapper
To: kamzik@dolly.vellum.cz (Karel Zatloukal)
Date: Mon, 6 Nov 2000 18:21:24 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200011062121.eA6LLir27520@dolly.vellum.cz> from "Karel Zatloukal" at Nov 06, 2000 10:21:44 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The UID/GID mapper should be sepatate from the regex rewriting rules.
Both should be separate from NFS, because they have little to do with NFS.
These are useful generic VFS features. It would be perfectly reasonable
to use these features on a Zip disk with UFS (from MacOS X maybe).

Another example: given two Linux boxes with existing user accounts,
how does one merge them together into one box? The UID/GID remapper
could be helpful for this; just put both disks in the same box and
remap as needed.

The pathname remapper might best be done as a namespace operation
similar to mounting. Given a read-only /usr on CD-ROM or NFS with
an exploitable /usr/bin/suidperl, I'd like to "mount" a new
executable on top of that from /bin/good-suidperl to fix the hole.
Even more interesting is the case where /usr/bin/setuidperl does
not exist at all, so there isn't anything to use for a mount point,
but I have scripts that need to use it.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
