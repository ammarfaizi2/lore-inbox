Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265082AbUG2Tqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbUG2Tqo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUG2Tqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:46:44 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:16786 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265082AbUG2Tql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:46:41 -0400
Date: Thu, 29 Jul 2004 14:46:35 -0500
From: Greg Howard <ghoward@sgi.com>
X-X-Sender: ghoward@gallifrey.americas.sgi.com
To: Sam Ravnborg <sam@ravnborg.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix system controller communication driver
In-Reply-To: <20040728182126.GB14737@mars.ravnborg.org>
Message-ID: <Pine.SGI.4.58.0407291425330.1917@gallifrey.americas.sgi.com>
References: <Pine.SGI.4.58.0407271457240.1364@gallifrey.americas.sgi.com>
 <20040728085737.26e0bfd2.akpm@osdl.org> <20040728182126.GB14737@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004, Sam Ravnborg wrote:

> I would also recommend running it through sparse.
> http://sparse.bkbits.net
> davej has a .tar.gz package somewhere at www.codemonkey.org.uk.
>
> I did not see any particular issue, but noticed no __user annotations
> around copy_{to,from}_user().

I did add the __user annotations to the parameters in scdrv_read() and
scdrv_write().  But I had trouble coming up with a type-casting chant
around my invocations of copy_{to,from}_user() that would satisfy
sparse.  No matter what I did it still gave me some warnings.

FWIW I looked through a couple of other drivers (and ran them through
sparse to see what would happen), and I discovered that I seem to be
in good company as far as this is concerned...  Are there any examples
of a use of copy_{to,from}_user() that use char* parameters (perhaps
cast to something else), but don't cause sparse to complain?

Thanks - Greg
