Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUIEONr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUIEONr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 10:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUIEONq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 10:13:46 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:52378 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S266687AbUIEONm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 10:13:42 -0400
Date: Sun, 5 Sep 2004 16:13:33 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <264532836.20040905161333@tnonline.net>
To: Tonnerre <tonnerre@thundrix.ch>
CC: Helge Hafting <helge.hafting@hist.no>, Oliver Hunt <oliverhunt@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <20040905134428.GN26560@thundrix.ch>
References: <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
 <4136A14E.9010303@slaphack.com>
 <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
 <4136C876.5010806@namesys.com>
 <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
 <4136E0B6.4000705@namesys.com> <4699bb7b04090202121119a57b@mail.gmail.com>
 <4136E756.8020105@hist.no> <4699bb7b0409020245250922f9@mail.gmail.com>
 <413829DF.8010305@hist.no> <20040905134428.GN26560@thundrix.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Salut,

> On Fri, Sep 03, 2004 at 10:22:55AM +0200, Helge Hafting wrote:
>> Requiring another syscall to open forks other than the primary
>> breaks _all_ existing software because it obviously don't use that
>> syscall yet.  And then it doesn't provide any advantages over the
>> file-as-plain-directory way. . .

> Actually...

> We might tune the sys_open()  call to take an additional argument (the
> stream ID),  and introduce a compatibility interface  into *libc which
> chooses strid=0 by default if the plain old open call is being used.

> Maybe this can be handled transparently by cpp..

  How are things like copy handled today? Is it just some code linked
  in during compilation (ie, the application handles the copy itself)
  or is it a library function in libc? If it is in libc then it ought
  to be enough if libc is patched to support the new semantics with
  file-as-dir etc.

  ~S


> 		Tonnerre

