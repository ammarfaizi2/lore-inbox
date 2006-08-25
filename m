Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWHYNJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWHYNJs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWHYNJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:09:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:635 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751034AbWHYNJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:09:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Xf1MnfNpVaY9yFiZNNtzggZpQNtQeABZnpeZVS9i+udYtEBF/5evMQZsVeF/Tlz1PCMAW7Rd2T+GMrPLcijpf/aj4P2o4jw5Ev90sbVfjRN+0hZy5pLF/ncrgb0xwSGBWz6VNcTauf/E9IHlZIHEteY939Sdi2bWQgST/sA/7jk=
Date: Fri, 25 Aug 2006 17:09:39 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
Message-ID: <20060825130939.GB5205@martell.zuzino.mipt.ru>
References: <32640.1156424442@warthog.cambridge.redhat.com> <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org> <20060824155814.GL19810@stusta.de> <1156435216.3012.130.camel@pmac.infradead.org> <20060824160926.GM19810@stusta.de> <20060824164752.GC5205@martell.zuzino.mipt.ru> <20060824170709.GO19810@stusta.de> <Pine.LNX.4.61.0608250806560.7912@yvahk01.tjqt.qr> <20060825103754.GW19810@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825103754.GW19810@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 12:37:54PM +0200, Adrian Bunk wrote:
> On Fri, Aug 25, 2006 at 08:07:37AM +0200, Jan Engelhardt wrote:
> > >
> > >There's e.g. no reason to ask all users whether they want to compile all
> > >I/O schedulers into their kernel.
> > >
> > The users that do not know how to handle it should not be compiling a
> > kernel. If in doubt, they should read the help texts and follow the "If
> > unsure" clause listed there.
>
> If your distribution ships 2.6.x and your hardware is not supported
> before 2.6.x+1 you need your own kernel.
>
> The expectation "only kernel hackers don't use distribution kernels" is
> wrong in too many cases.
>
> "System administrator" is a target audience of the kernel configuration,
> and we should make it as easy as possible for such people to compile
> their own kernel.

This is solvable with good help texts.

	config IOSCHED_PRON
	tristate
	  The pr0n I/O scheduler is specifically tuned for one specific
	  task -- busy webserver shipping pr0n to customers. Distributions of
	  file sizes and access patterns were heavily analyzed during
	  development.

	  To make such server even more faster also select "pr0n filesystem
	  support" in File systems menu and read help text there.

	  If you aren't in pr0n industry, say N.

