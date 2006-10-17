Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWJQUfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWJQUfG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWJQUfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:35:06 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:3992 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751377AbWJQUfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:35:02 -0400
Date: Tue, 17 Oct 2006 16:33:39 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew James Wade <andrew.j.wade@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       hch@infradead.org, Al Viro <viro@ftp.linux.org.uk>,
       linux-fsdevel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       ezk@cs.sunysb.edu, mhalcrow@us.ibm.com
Subject: Re: [PATCH 1 of 2] fsstack: Introduce fsstack_copy_{attr,inode}_*
Message-ID: <20061017203339.GA30847@filer.fsl.cs.sunysb.edu>
References: <fe7c146c6457a4b288ab.1161060147@thor.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0610171237220.22888@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0610171237220.22888@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 12:40:31PM +0200, Jan Engelhardt wrote:
> 
> >To: null@josefsipek.net
> 
> (Superb idea to prekill any Cc, re-adding them)
 
Yeah, I like to test the emails but I accidentally sent them. From now on,
no testing :)
 
> >+void __fsstack_copy_attr_all(struct inode *dest,
> >+			     const struct inode *src,
> >+			     int (*get_nlinks)(struct inode *))
> >+{
> >[big]
> >+}
> >+
> >+/* externs for fs/stack.c */
> >+extern void __fsstack_copy_attr_all(struct inode *dest,
> >+				    const struct inode *src,
> >+				    int (*get_nlinks)(struct inode *));
> >+
> >+static inline void fsstack_copy_attr_all(struct inode *dest,
> >+					 const struct inode *src)
> >+{
> >+	__fsstack_copy_attr_all(dest, src, NULL);
> >+}
> 
> Do we really need this indirection? Can't __fsstack_copy_attr_all be 
> named fsstack_copy_attr_all instead?

I suppose it could. There is no API-breakage to avoid.

Josef "Jeff" Sipek.

-- 
Computer Science is no more about computers than astronomy is about
telescopes.
		- Edsger Dijkstra
