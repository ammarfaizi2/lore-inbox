Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWJJXx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWJJXx3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWJJXx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:53:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56009 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030357AbWJJXx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:53:27 -0400
Date: Tue, 10 Oct 2006 16:53:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Riss?= <frederic.riss@gmail.com>
cc: Pavel Machek <pavel@ucw.cz>, Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com
Subject: Re: 2.6.18 suspend regression on Intel Macs
In-Reply-To: <1160518195.5134.38.camel@funkylaptop>
Message-ID: <Pine.LNX.4.64.0610101649440.3952@g5.osdl.org>
References: <1160417982.5142.45.camel@funkylaptop>  <20061010103910.GD31598@elf.ucw.cz>
  <1160476889.3000.282.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.64.0610100830370.3952@g5.osdl.org>  <1160507296.5134.4.camel@funkylaptop>
  <1160509121.3000.327.camel@laptopd505.fenrus.org>  <1160509584.5134.11.camel@funkylaptop>
 <20061010195022.GA32134@elf.ucw.cz>  <Pine.LNX.4.64.0610101447270.3952@g5.osdl.org>
 <1160518195.5134.38.camel@funkylaptop>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-665367434-1160524396=:3952"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-665367434-1160524396=:3952
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Wed, 11 Oct 2006, Frédéric Riss wrote:
>
> I was about to send a patch doing exactly the same. It fixes the issue
> for me. Thanks.

Hmm. My Mac Mini doesn't restore properly even with it, but I suspect it's 
the old DRM "resume AGP in the wrong order" problem.

When trying to verify that, though, I noticed that if I enable the "keep 
console active over suspend", then it won't even suspend. It hangs after 
printing "i801_smbus 0000:00:1f.3: suspend".

I'm wondering what Pavel does for debugging these things, since the claim 
was that keeping printk() active would make debugging easier. As it is, it 
just seems to break suspend exactly because it wants to access devices 
that are turned off.

Pavel?

		Linus
--21872808-665367434-1160524396=:3952--
