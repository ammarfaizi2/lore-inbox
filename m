Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271814AbTHML32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271829AbTHML32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:29:28 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:9976 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271814AbTHML3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:29:23 -0400
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: maney@pobox.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephan von Krawczynski <skraw@ithnet.com>
In-Reply-To: <20030812213645.GA1079@furrr.two14.net>
References: <20030812165624.GA1070@furrr.two14.net>
	 <Pine.LNX.4.44.0308121408450.10045-100000@logos.cnet>
	 <20030812213645.GA1079@furrr.two14.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060774108.8008.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 13 Aug 2003 12:28:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-12 at 22:36, Martin Maney wrote:
> but that made no difference.  I popped a CMD648-based card in, disabled
> the on-board Promise chip, and it booted right up and works fine with
> 22-rc2.  So if the .id -> .present is the only change that affected the
> Promise driver (I did some looking for obvious, but gave up after
> realizing that unless the change actually had a /* borks Promise IDE
> controllers*/ in it I wouldn't be likely to recognize it), then I guess
> that's it.

That change simple turns

		speed = random()?33:66 (but never > drive allows)

to
		speed = correct value

in the pdc202xx_old driver. There are many things it can trigger but I
cannot conceive how it can be wrong itself. And not fixing it leaves it 
definitely wrong


