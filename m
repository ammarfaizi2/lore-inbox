Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271106AbRIFPLR>; Thu, 6 Sep 2001 11:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271124AbRIFPLG>; Thu, 6 Sep 2001 11:11:06 -0400
Received: from ns.ithnet.com ([217.64.64.10]:19470 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271106AbRIFPKx>;
	Thu, 6 Sep 2001 11:10:53 -0400
Date: Thu, 6 Sep 2001 17:10:49 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: phillips@bonn-fries.net, riel@conectiva.com.br, jaharkes@cs.cmu.edu,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
Message-Id: <20010906171049.4d40da02.skraw@ithnet.com>
In-Reply-To: <598034578.999792124@[10.132.112.53]>
In-Reply-To: <20010906163909.186b8b46.skraw@ithnet.com>
	<598034578.999792124@[10.132.112.53]>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Sep 2001 16:02:04 +0100 Alex Bligh - linux-kernel
<linux-kernel@alex.org.uk> wrote:

> Stephan,
> >> You yourself proved this, by switching rsize,wsize to 1k and said
> >> it all worked fine! (unless I misread your email).
> >
> > Sorry, misunderstanding: I did not touch rsize/wsize. What I do is to lower
fs
> > action by not letting knfsd walk through the subtrees of a mounted fs. This
> > leads to less allocs/frees by the fs layer which tend to fail and let knfs
fail
> > afterwards.
> 
> OK, I'm getting confused.

To end that:

What I meant was, I did not touch the values most everybody uses on NFS, which
is:
rsize=8192,wsize=8192
Using smaller values (or default = 1024) gives such a ridicolously bad
performance that I would even prefer samba.

Regards,
Stephan


