Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTD1FEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 01:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTD1FEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 01:04:53 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:3968 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S263461AbTD1FEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 01:04:52 -0400
Date: Mon, 28 Apr 2003 06:16:59 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Mark Grosberg <mark@nolab.conman.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
Message-ID: <20030428051658.GA8294@mail.jlokier.co.uk>
References: <Pine.LNX.4.53.0304271831250.8792@twinlark.arctic.org> <Pine.BSO.4.44.0304272140340.23296-100000@kwalitee.nolab.conman.org> <20030428034415.GC32043@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428034415.GC32043@mark.mielke.cc>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> If the argument is that vfork(), exec()
> must scan the file descriptors to determine which ones have FD_CLOEXEC set,
> then perhaps the answer is to index the FD_CLOEXEC bits of file descriptors?

More precisely, to index the file descriptors whih do _not_ have the
FD_CLOEXEC bit set - those are the file descriptors to copy into the
new process.

A more relevant optimisation is to make searching for new file
descriptors O(1) in accept(), yet that was discussed years ago and it
was decided it wasn't worth doing.

-- Jamie
