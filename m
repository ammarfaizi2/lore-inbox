Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVAGBBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVAGBBc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVAGA6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:58:37 -0500
Received: from [213.146.154.40] ([213.146.154.40]:54961 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261153AbVAGAtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:49:00 -0500
Date: Fri, 7 Jan 2005 00:48:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulmck@us.ibm.com,
       arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050107004850.GA29346@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	paulmck@us.ibm.com, arjan@infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com,
	markv@us.ibm.com, greghk@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <1105053007.17176.291.camel@localhost.localdomain> <Pine.LNX.4.58.0501061623350.2272@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501061623350.2272@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 04:24:58PM -0800, Linus Torvalds wrote:
> At that point there is a specific _reason_ to break it, aka "that function 
> simply doesn't exist any more".
> 
> I'm known for happily breaking binary modules, but I think we should do it 
> only if we have a reason _other_ than "let's break a module". 

Note that the function that started this thread weren't removed with nwfs
in mind - in fact I doubt anyone here has seen the module or it's
requirements.

Arjan and I have produced lists of unused exported symbols and went through
the list what made sense and what not, and these exports were up high on the
doesn't make sense and any use we could imagine would be harmfull list.

The explained use only seconds that opinion - it has caused constant trouble
for years where IBM has been pushing the big distros to relax VFS sanity
checks and add additioal exports for their totally broken kernel driver.

That no beeing enough I know of at least two propritary Unix variants where
it cause exactly the same trouble.
