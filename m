Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272840AbTHEO4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 10:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272841AbTHEO4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 10:56:44 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:62970 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S272840AbTHEO4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 10:56:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
       Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: FS: hardlinks on directories
Date: Tue, 5 Aug 2003 09:56:11 -0500
X-Mailer: KMail [version 1.2]
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <20030804141548.5060b9db.skraw@ithnet.com> <20030805150351.5b81adfe.skraw@ithnet.com> <Pine.LNX.4.53.0308050916140.5994@chaos>
In-Reply-To: <Pine.LNX.4.53.0308050916140.5994@chaos>
MIME-Version: 1.0
Message-Id: <03080509561102.05972@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 August 2003 08:36, Richard B. Johnson wrote:
[snip]
>
> Somebody mentioned that VAX/VMS would allow hard-linked
> directories. This is not true. Even files, created with
> SET FILE ENTER=DUA0:[1.DIR] DUA0:[000000] that seemed
> like hard links were not hard links. They were sim-links.
> The file entry contained the directory information of the
> file being linked, and was not a clone of the header
> (inode) itself as would be a hard link. Therefore, these
> were unique and could not cause recursion to fail.

Those created with "set file enter" are.

Those created with "pip file file/link" are/were hard links.
(at least I think I got the command right. There was a
syntax to specified a file node directory, but the number,sequence
syntax is forgotten).

found this on VAX 8800s... Each boot directory was a
hard link to the common boot directory. One hard link per
cluster node entry. That eliminated the duplicated code,
and still permitted unique boots during rolling upgrades.
As well as permitted different architectures to use the
cluster filesystem.

It had to be a hard link because the boot code
couldn't/didn't handle the others.

the "analyze/disk" would find these as "incorrect parent"
references, and would attempt to repair them by switching
the parent directory entries. A subsequent check would
report the other entry as incorrect...
