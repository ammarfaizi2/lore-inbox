Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272135AbTHIBwK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272145AbTHIBwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:52:10 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:16516 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272135AbTHIBwG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:52:06 -0400
Date: Sat, 9 Aug 2003 02:51:40 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Theewara Vorakosit <g4685034@alpha.cpe.ku.ac.th>,
       linux-kernel@vger.kernel.org
Subject: Re: sendfile system call on tmpfs
Message-ID: <20030809015140.GE26375@mail.jlokier.co.uk>
References: <Pine.LNX.4.33.0308071831240.16498-100000@alpha.cpe.ku.ac.th> <Pine.LNX.4.44.0308071357470.2015-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308071357470.2015-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> The 2.4 tmpfs did not support sendfile (or loop) until 2.4.22-pre3,
> so Red Hat's 2.4.20-13.9smp won't do it.

Oh.  Does this mean that it is faster to serve program-generated data
by mmaping an ext3 file and using sendfile() on that, than to call
write() from anonymous memory?  The former does zero-copy, the latter
doesn't.  Unfortunately the former might write to disk, though you
don't want it too.

-- Jamie
