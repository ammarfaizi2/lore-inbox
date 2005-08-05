Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVHESop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVHESop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbVHESmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:42:45 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:48505 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262912AbVHESj5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:39:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XoRq2dmOnfcPXITOprhEfMwBY8AWeyczJoBxTeRjflpqfrZJjGL6ZUT1CeU/ZFyAGeAOW2oGOxb3Ezi5eabVaN6/6ZQlqUMx9BABTAWReZFRJmLRqg5kF+1QbadtTBWFY1kSRhD/bs0U0ygB4zZeFP/6zphtVWyGmWpl18YzBA4=
Message-ID: <feed8cdd0508051139799ff4d5@mail.gmail.com>
Date: Fri, 5 Aug 2005 11:39:55 -0700
From: Stephen Pollei <stephen.pollei@gmail.com>
Reply-To: Stephen Pollei <stephen.pollei@gmail.com>
To: Christoph Lameter <christoph@lameter.com>
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Pekka J Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       pmarques@grupopie.com, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0508051114001.31384@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1123219747.20398.1.camel@localhost>
	 <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI>
	 <20050804233634.1406e92a.akpm@osdl.org>
	 <Pine.LNX.4.61.0508051132540.3743@scrub.home>
	 <1123235219.3239.46.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0508051202520.3728@scrub.home>
	 <1123236831.3239.55.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0508051225270.3743@scrub.home>
	 <feed8cdd050805104954a07573@mail.gmail.com>
	 <Pine.LNX.4.62.0508051114001.31384@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/05, Christoph Lameter <christoph@lameter.com> wrote:

> Hmm. If we had kcmalloc then we may be able to add a zero bit to the slab
> allocator. If we would obtain zeroed pages for the slab then we may skip
> zeroing of individual entries. However, the cache warming effect of the
> current zeroing is then not occurring. Not sure if this would make sense
> but this is a possible optimization if we had kcmalloc.

Well there is kzalloc and kcalloc. I just thought a safe non-zeroing
version would be nice.
You could warm the cache with prefetch, but you'd need to profile the
diferent cases to see what is worth doing and what isn't.


-- 
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=2455954990164098214
http://stephen_pollei.home.comcast.net/
