Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbTGHNjD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267308AbTGHNjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:39:03 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:9613 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S267317AbTGHNgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:36:41 -0400
Date: Tue, 8 Jul 2003 14:51:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Eric Varsanyi <e0216@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
Message-ID: <20030708135109.GA15515@mail.jlokier.co.uk>
References: <20030707154823.GA8696@srv.foo21.com> <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com> <20030707194736.GF9328@srv.foo21.com> <Pine.LNX.4.55.0307071511550.4704@bigblue.dev.mcafeelabs.com> <Pine.LNX.4.55.0307071624550.4704@bigblue.dev.mcafeelabs.com> <20030708003247.GB12127@mail.jlokier.co.uk> <Pine.LNX.4.55.0307071730190.3524@bigblue.dev.mcafeelabs.com> <20030708005226.GD12127@mail.jlokier.co.uk> <Pine.LNX.4.55.0307071802360.3531@bigblue.dev.mcafeelabs.com> <20030708123421.GB14827@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030708123421.GB14827@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doh!  I'm sorry.  I forgot that the lookup key is actually (epoll_fd,
file *, fd).

So all I said in the parent mail about problems with fds shared among
multiple processes is nonsense - they will each have a different
epoll_fd, so maintain separate epoll state.

Remember not to take me seriously in future.
(Oh, you weren't... :)

-- Jamie (blushing)
