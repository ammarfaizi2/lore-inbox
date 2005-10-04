Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbVJDTnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbVJDTnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbVJDTnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:43:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:7592 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964937AbVJDTnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:43:01 -0400
Date: Tue, 4 Oct 2005 20:43:01 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: David Leimbach <leimy2k@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /etc/mtab and per-process namespaces
Message-ID: <20051004194301.GO7992@ftp.linux.org.uk>
References: <3e1162e60510021508r6ef8e802p9f01f40fcf62faae@mail.gmail.com> <3e1162e60510041214t3afd803re27b742705d27900@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1162e60510041214t3afd803re27b742705d27900@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 12:14:47PM -0700, David Leimbach wrote:
> Hmm no responses on this thread a couple days now.  I guess:
> 
> 1) No one cares about private namespaces or the fact that they make
> /etc/mtab totally inconsistent.
> 2) Private Namespaces aren't important to anyone and will never be
> robust unless someone who cares, like me, takes it over somehow.
> 3) Everyone is busy with their own shit and doesn't want to deal with
> me or mine right now.

4) If you insist on having /etc/mtab the same file in all namespaces,
you obviously will have its contents not matching at least some
of them.  Either have it separate in each namespace where you want
to see it, or simply use /proc/self/mounts instead.

BTW, "private" is an odd term - they are all on the same footing; "system"
one is just the namespace of init (and those of its descendents that share
the namespace with it).  Nothing special about it...
