Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267889AbUIFMoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267889AbUIFMoE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 08:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267920AbUIFMoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 08:44:04 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:41164 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S267889AbUIFMn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 08:43:58 -0400
Date: Mon, 6 Sep 2004 14:43:57 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: Tonnerre <tonnerre@thundrix.ch>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040906124357.GB27133@MAIL.13thfloor.at>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	Tonnerre <tonnerre@thundrix.ch>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@osdl.org>,
	Jamie Lokier <jamie@shareable.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Adrian Bunk <bunk@fs.tum.de>, Hans Reiser <reiser@namesys.com>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <20040906075603.GB28697@thundrix.ch> <20040906080845.GA31483@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906080845.GA31483@janus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 10:08:45AM +0200, Frank van Maarseveen wrote:
> On Mon, Sep 06, 2004 at 09:56:03AM +0200, Tonnerre wrote:
> > 
> > $ cat fs_header owner_root flags_with_suid evil_program > evil.iso
> > $ ls -l evil.iso/evil_program
> 
> It should of course be equivalent to a user mount: nodev nosuid etc.

hmm, sounds reasonable, but what if root accesses it?
(or somebody with the 'right' capability)

 - it might be strange if even root is not able to
   open device nodes or execute files from an archive

 - it might lead to interesting situations if the
   archive is opened by root, but accessed by an user
   (thinking of caches and such)
  
best,
Herbert

> -- 
> Frank
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
