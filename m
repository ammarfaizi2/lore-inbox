Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWCMV7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWCMV7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWCMV7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:59:48 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:29544 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932483AbWCMV7r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:59:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n7mt3b0OD6pf+V67jepYudBg7ng3jOueXUkbwQd2BLJfiLklgvsx+j3Y4VWSUbRP6grYsBWoqfPV8iG+3uye5ajCYwOejjytKeytjIRZ+XRyRL4whd+Kdo0c3VJJuuu77Q+n8+rpZIPp6PutBRKPqsI7pkgzhy4x7jvEi0wOCAo=
Message-ID: <9a8748490603131359y2f7e3a57p646b8130f23ef59c@mail.gmail.com>
Date: Mon, 13 Mar 2006 22:59:46 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [PATCH] fix memory leak in mm/slab.c::alloc_kmemlist()
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603131344480.13027@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603121428.08226.jesper.juhl@gmail.com>
	 <20060312144129.0b5c227d.akpm@osdl.org>
	 <9a8748490603122334h6682be62r18f781003db88b20@mail.gmail.com>
	 <9a8748490603131333o1b252aeq9e7f4aca97295640@mail.gmail.com>
	 <Pine.LNX.4.64.0603131344480.13027@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/06, Christoph Lameter <clameter@sgi.com> wrote:
> On Mon, 13 Mar 2006, Jesper Juhl wrote:
>
> > Ok, I've been playing around with a few ways to resolve this, but I'm
> > a bit pressed for time and won't have properly tested patches ready
> > tonight. I will however keep at this, so you'll see patches
> > releatively shortly, just give me another day or two and I'll have
> > this fixed in a nice way (nice little task to work at :) ...
>
> Maybe extract a alloc_kmemlist_node and free_kmemlist_node from
> alloc_kmemlist()? It gets a bit complicated if all of this is handled within
> alloc_kmemlist and having these separate may simplify recovery on out of
> memory.
>
Nice Idea. So far I've been trying to handle it all inside the
function, but maybe sepperating stuff out might simplify it..
anyway, i'll keep working on this and will submit patches in a day or two...
It really is a nice little problem to work on and I'll find a solution
for it (well, I already have at least one, but it's ugly as hell, want
to find a better one) - gimme a few days.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
