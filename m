Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVFXMw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVFXMw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 08:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVFXMw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 08:52:56 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:6672 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262401AbVFXMtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 08:49:53 -0400
Date: Fri, 24 Jun 2005 14:49:43 +0200
From: Olivier Galibert <galibert@pobox.com>
To: David Masover <ninja@slaphack.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050624124943.GA75817@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	David Masover <ninja@slaphack.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB7B32.4010100@slaphack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BB7B32.4010100@slaphack.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 10:17:06PM -0500, David Masover wrote:
> I was able to recover from bad blocks, though of course no Reiser that I
> know of has had bad block relocation built in...  But I got all my files
> off of it, fortunately.

My experience shows that you've been very, very lucky.  I hope r4 is
better in that regard.

If you want to try with r3, take a well-used partition[1] and copy it
at block level to another partition or a file.  Then zero some random
spans of blocks in the copy and reiserfsck --rebuild-tree it.  My
experience is that you'll usually get the files names and directory
tree but their contents will have been scattered all over the place.

  OG.

[1] I suspect a minimum of fragmentation is in order to see the
problem

