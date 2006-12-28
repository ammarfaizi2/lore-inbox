Return-Path: <linux-kernel-owner+w=401wt.eu-S964905AbWL1Fi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWL1Fi0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 00:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWL1Fi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 00:38:26 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:2295 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964905AbWL1FiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 00:38:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uP1nByQbBq3mLmBXtsH6K98J4MKoeHzjoRMUGensoppZMf7cHa7Y74rLcJ7Cq43wzNUQFOKuvl+cONM07QqXnPhyGodJ223fLnWy+tsqfbYB3n1Weq8ZEbU3HfXhnub5j/LFnny5Q7KcT7uZcu1E54liCFT3oAZ5fg2IHMpqqrI=
Message-ID: <97a0a9ac0612272138o5348488ahfde03f9e22a71b5d@mail.gmail.com>
Date: Wed, 27 Dec 2006 22:38:24 -0700
From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Cc: "David Miller" <davem@davemloft.net>, ranma@tdiedrich.de, tbm@cyrius.com,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       "Andrew Morton" <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612272120180.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061226.205518.63739038.davem@davemloft.net>
	 <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
	 <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org>
	 <20061227.165246.112622837.davem@davemloft.net>
	 <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
	 <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com>
	 <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org>
	 <97a0a9ac0612272115g4cce1f08n3c3c8498a6076bd5@mail.gmail.com>
	 <Pine.LNX.4.64.0612272120180.4473@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/06, Linus Torvalds <torvalds@osdl.org> wrote:

> On Wed, 27 Dec 2006, Gordon Farquharson wrote:
> >
> > I don't think so. I did reduce the target size
> >
> > #define TARGETSIZE (100 << 12)
>
> That's just 400kB!
>
> There's no way you should see corruption with that kind of value. It
> should all stay solidly in the cache.
>
> Is this perhaps with ARM nommu or something else strange? It may be that
> the program just doesn't work at all if mmap() is faked out with a malloc
> or similar.

Definitely a question for the ARM gurus. I'm out of my depth.

Gordon

-- 
Gordon Farquharson
