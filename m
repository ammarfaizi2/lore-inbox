Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271174AbTG1XC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271186AbTG1XC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:02:59 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:34753 "HELO
	develer.com") by vger.kernel.org with SMTP id S271174AbTG1XCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:02:10 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: Nicolas Pitre <nico@cam.org>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Date: Tue, 29 Jul 2003 01:02:01 +0200
User-Agent: KMail/1.5.9
Cc: Willy Tarreau <willy@w.ods.org>, Christoph Hellwig <hch@lst.de>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.44.0307281307480.6507-100000@xanadu.home>
In-Reply-To: <Pine.LNX.4.44.0307281307480.6507-100000@xanadu.home>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307290102.01313.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 July 2003 19:13, Nicolas Pitre wrote:

> > Removing the I/O schedulers is pretty trivial, please come up with a
> > patch to make both of them optional and maybe add a trivial noop one.
> >
> > Removing sysfs should also be pretty trivial but I'm not sure whether
> > you really want that.
>
> Being able to remove the block layer entirely, just as for the networking
> layer, should be considered too, since none of ramfs, tmpfs, nfs, smbfs,
> jffs and jffs2 just to name those ones actually need the block layer to
> operate.  This is really a big pile of dead code in many embedded setups.

It's a great idea.

I've read in the Kconfig help that JFFS2 still depends on mtdblock even
though it doesn't use it for I/O. I think I've also seen some promise
that this dependency will eventually be removed...

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


