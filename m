Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268333AbUIGTbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268333AbUIGTbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268490AbUIGT2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:28:13 -0400
Received: from mx02.qsc.de ([213.148.130.14]:53904 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S268526AbUIGTYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:24:03 -0400
Date: Tue, 07 Sep 2004 21:22:33 +0200
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: Hans Reiser <reiser@namesys.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Tonnerre <tonnerre@thundrix.ch>,
       Spam <spam@tnonline.net>, ReiserFS List <reiserfs-list@namesys.com>,
       Pavel Machek <pavel@ucw.cz>, David Masover <ninja@slaphack.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Jamie Lokier <jamie@shareable.org>, Christoph Hellwig <hch@lst.de>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Chris Wedgwood <cw@f00f.org>, Christer Weinigel <christer@weinigel.se>
Subject: Re: silent semantic changes with reiser4
Message-ID: <413E0A79.nailEBK11DW72@pluto.uni-freiburg.de>
References: <200409070206.i8726vrG006493@localhost.localdomain>
 <413D4C18.6090501@slaphack.com> <m3d60yjnt7.fsf@zoo.weinigel.se>
 <413DA8EE.nailA301JQ74H@pluto.uni-freiburg.de>
 <413DFC06.5070604@namesys.com>
In-Reply-To: <413DFC06.5070604@namesys.com>
User-Agent: nail 11.7pre 9/7/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:

> Gunnar Ritter wrote:
> >You cannot just 'modify cp'. 
> >
> People who think that POSIX is the objective rather than the least 
> common denominator of OS design

I am not principally adversed against extensions to POSIX. My mailx
implementation 'nail' has e.g. perhaps more extensions than there are
commands and options in the POSIX standard for it.

POSIX is also not against extensions. In fact, POSIX development
generally works as follows: One vendor creates something as an extension,
other vendors follow to implement it, and later on it is discussed if it
is desirable to integrate the feature into the standard itself. It is
absolutely possible that Sun's openat() might be in POSIX.1-2010 one day,
for example. Useful extensions are thus welcome to POSIX.

This does not mean, however, that one should not clearly distinct between
standard and extensions, and that extensions should be created at will
without carefully weighting pros and cons.

I did not say: POSIX forbids to handle streams or directory/file mixes.
This would not even have been true. However, POSIX restricts the choice
of possible interfaces for them. One of those restrictions is that 'cp'
may not copy streams if used in strict accordance with POSIX. As you
acknowledged in your reply, POSIX is the least common denominator. Thus
'cp' implementations should not be modified in a way that violates it.

This means, in effect, that a strictly conforming POSIX application (i.e.
something like a shell script that uses no POSIX extensions or methods
which are not clearly defined in the standard) will very likely be unable
to copy streams, unless some other, conforming, method is found. Which is
a problem one should know about when discussing this.

> have had their head screwed on backwards 
> to better look at where their competitors used to be.

But there are not only forwards and backwards directions. Sideways might
lead to nowhere.

	Gunnar

-- 
http://omnibus.ruf.uni-freiburg.de/~gritter
