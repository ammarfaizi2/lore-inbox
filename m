Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271413AbTHRMLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271415AbTHRMLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:11:00 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:57984 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S271413AbTHRMKF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:10:05 -0400
Date: Mon, 18 Aug 2003 13:09:55 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use simple_strtoul for unsigned kernel parameters
Message-ID: <20030818120955.GB7147@mail.jlokier.co.uk>
References: <20030818004618.GA5094@mail.jlokier.co.uk> <20030818101524.5B12D2C019@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818101524.5B12D2C019@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <20030818004618.GA5094@mail.jlokier.co.uk> you write:
> > The largest "unsigned int" value doesn't fit in a "long", on many machines.
> > So we should use simple_strtoul, not simple_strtol, to decode these values.
> 
> Half right.  The second part is fine, the first part is redundant

Do you mean the first part of the comment or the first part of the patch?

Assuming you mean the patch, you're right: the unsigned short case
doesn't need to be changed.  It should be anyway because it is just
the right thing to do.

-- Jamie
