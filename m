Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270330AbTGWNuL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 09:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270332AbTGWNuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 09:50:11 -0400
Received: from rth.ninka.net ([216.101.162.244]:47744 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S270330AbTGWNuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 09:50:08 -0400
Date: Wed, 23 Jul 2003 07:04:31 -0700
From: "David S. Miller" <davem@redhat.com>
To: David Korn <dgk@research.att.com>
Cc: linux-kernel@vger.kernel.org, gsf@research.att.com, netdev@oss.sgi.com
Subject: Re: kernel bug in socketpair()
Message-Id: <20030723070431.13859c09.davem@redhat.com>
In-Reply-To: <200307231332.JAA26197@raptor.research.att.com>
References: <200307231332.JAA26197@raptor.research.att.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 09:32:09 -0400 (EDT)
David Korn <dgk@research.att.com> wrote:

[ Added netdev@oss.sgi.com, the proper place to discuss networking kernel issues. ]

> The first problem is that files created with socketpair() are not accessible
> via /dev/fd/n or /proc/$$/fd/n where n is the file descriptor returned
> by socketpair().  Note that this is not a problem with pipe().

Not a bug.

Sockets are not openable via /proc files under any circumstances,
not just the circumstances you describe.  This is a policy decision and
prevents a whole slew of potential security holes.
