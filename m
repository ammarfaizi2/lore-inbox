Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbVK3QNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbVK3QNu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVK3QNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:13:50 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:35887 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751431AbVK3QNt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:13:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U86naj5YnNggAtBPCFOOaFuT7Oazmnxbg2+5BSXvzorodtyR5t1RKXGgXFHnv0/tclP95ZtFBvANr6RpUJnKcJe0h03fCfgy9gzqFj7wUb2RR4CGk/h4bpP3rUqlOH5Fek41O7KJdQhpi2w2qe1ltK6PUK/iGEuqh8GdcLpHU3g=
Message-ID: <9a8748490511300813n738646esfe568041afe9f97@mail.gmail.com>
Date: Wed, 30 Nov 2005 17:13:47 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: [PATCH 0/9] x86-64 put current in r10
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051130151847.GE5706@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051130042118.GA19112@kvack.org>
	 <20051130151847.GE5706@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/05, Matti Aarnio <matti.aarnio@zmailer.org> wrote:
> On Tue, Nov 29, 2005 at 11:21:18PM -0500, Benjamin LaHaise wrote:
> > Date: Tue, 29 Nov 2005 23:21:18 -0500
> > From: Benjamin LaHaise <bcrl@kvack.org>
> > To:   Andi Kleen <ak@suse.de>
> > Cc:   linux-kernel@vger.kernel.org
> > Subject: [PATCH 0/9] x86-64 put current in r10
> >
> > Hello Andi,
> >
> > The following emails contain the patches to convert x86-64 to store current
> > in r10 (also at http://www.kvack.org/~bcrl/patches/v2.6.15-rc3/).  This
> > provides a significant amount of code savings (~43KB) over the current
> > use of the per cpu data area.  I also tested using r15, but that generated
> > code that was larger than that generated with r10.  This code seems to be
> > working well for me now (it stands up to 32 and 64 bit processes and ptrace
> > users) and would be a good candidate for further exposure.
>
> I would rather prefer NOT to introduce this at this time.
> My primary concern is that during "even numbered series" there
> should not be radical internal ABI/API changes, like this one.
>
http://sosdg.org/~coywolf/lxr/source/Documentation/stable_api_nonsense.txt


> In 2.7 it can be introduced, by all means.
>
As many others have pointed out, there's not likely to be a 2.7 series
nytime in the forseable future. 2.6.x is where development happens.
Which in large part is why we have the -mm tree to test new stuff
before it hits mainline.
Check the sections on the various trees in
http://sosdg.org/~coywolf/lxr/source/Documentation/applying-patches.txt


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
