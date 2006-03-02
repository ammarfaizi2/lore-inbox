Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWCBSXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWCBSXU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWCBSXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:23:20 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:30361 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964784AbWCBSXT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:23:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o5yuq0Lz/A+SUJuC35UV8/nTUmJbJIW1ZpgwJZ6uRUChNiUOrXGt/8l2fYHBKuZBaJyO93CusGTdqo9CQNymnlr1XIPueHAnV/dXVNuGQb4sf64g8Sf+FUjlG4NCqX/G7St/PFh0eAlIhkB+y/iFDs6EF/20rK76rty5nS9//CY=
Message-ID: <9a8748490603021023j4c9af732y9d52a2a4a6f4ee97@mail.gmail.com>
Date: Thu, 2 Mar 2006 19:23:18 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: Another compile problem with 2.6.15.5 on AMD64
Cc: "Steffen Weber" <email@steffenweber.net>, linux-kernel@vger.kernel.org,
       "Christoph Lameter" <christoph@lameter.com>,
       J.E.J.Bottomley@hansenpartnership.com, stable@kernel.org
In-Reply-To: <200603021917.52268.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <44071AF3.1010400@steffenweber.net>
	 <4407347F.1000209@steffenweber.net>
	 <200603021916.50053.jesper.juhl@gmail.com>
	 <200603021917.52268.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/06, Andi Kleen <ak@suse.de> wrote:
> On Thursday 02 March 2006 19:16, Jesper Juhl wrote:
>
> > Andi, Christoph : would this make sense as a fix for -stable ?
>
> It's already fixed in stable.
>

Hmm, ok, so it's in the queue for 2.6.15.6 (since it obviously isn't
in current 2.6.15.5 -stable as that's where Steffen hit it), that's
good.

> > How about mainline ?
>
> mainline never had this problem. The backport was just bad.
>

Hmm, I see that at least two things from the patch seems to be
aplicable to at least current -mm (haven't checked latest Linus -git
yet).
The bit that removes BITS_PER_BYTE from
arch/i386/mach-voyager/voyager_cat.c and the bit that removes the
duplicate #include <linux/mempolicy.h> and substitutes it with
#include <linux/types.h>  those bits would seem to apply to
2.6.16-rc5-mm1

include/linux/types.h already has the BITSPER_BYTE define in -mm.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
