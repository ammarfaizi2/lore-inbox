Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269914AbUJMXYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269914AbUJMXYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269910AbUJMXYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:24:00 -0400
Received: from peabody.ximian.com ([130.57.169.10]:53151 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269911AbUJMXX4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:23:56 -0400
Subject: Re: Announcing Binary Compatibility/Testing
From: Robert Love <rml@novell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Timothy D. Witham" <wookie@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <416DAEB7.4050108@pobox.com>
References: <1097705813.6077.52.camel@wookie-zd7>
	 <416DAEB7.4050108@pobox.com>
Content-Type: text/plain
Date: Wed, 13 Oct 2004 19:24:15 -0400
Message-Id: <1097709855.5411.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 18:39 -0400, Jeff Garzik wrote:

> Userland ABI compatibility has always been a strongly held value in 
> Linux, I don't think we would flame any efforts to support that...

Yah.  With the exception of maybe changing something in /proc (which has
been rare, and hopefully will never happen with /sys) the kernel-to-user
ABI is really stable.

I'd venture, in fact, to say that this effort is very important but does
not affect the kernel at all.  Current "fault" lies in things e.g. like
the C++ ABI, which is constantly fluctuating (rightly so, to fix bugs,
but still).

Any other incompatibility lies in libraries, but we have library
versioning.  There is nothing wrong with newer libs breaking
compatibility so long as they have a different soname.  Vendors just
need to ship compat libs and ISV's need to make sure they request the
right lib and don't touch internals.

	Robert Love


