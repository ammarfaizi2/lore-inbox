Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271848AbTHMLhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271883AbTHMLhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:37:24 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:64987 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271848AbTHMLhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:37:22 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 13 Aug 2003 13:37:20 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: maney@pobox.com
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
Message-Id: <20030813133720.69f756d5.skraw@ithnet.com>
In-Reply-To: <1060774108.8008.16.camel@localhost.localdomain>
References: <20030812165624.GA1070@furrr.two14.net>
	<Pine.LNX.4.44.0308121408450.10045-100000@logos.cnet>
	<20030812213645.GA1079@furrr.two14.net>
	<1060774108.8008.16.camel@localhost.localdomain>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Aug 2003 12:28:31 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2003-08-12 at 22:36, Martin Maney wrote:
> > but that made no difference.  I popped a CMD648-based card in, disabled
> > the on-board Promise chip, and it booted right up and works fine with
> > 22-rc2.  So if the .id -> .present is the only change that affected the
> > Promise driver (I did some looking for obvious, but gave up after
> > realizing that unless the change actually had a /* borks Promise IDE
> > controllers*/ in it I wouldn't be likely to recognize it), then I guess
> > that's it.
> 
> That change simple turns
> 
> 		speed = random()?33:66 (but never > drive allows)
> 
> to
> 		speed = correct value
> 
> in the pdc202xx_old driver. There are many things it can trigger but I
> cannot conceive how it can be wrong itself. And not fixing it leaves it 
> definitely wrong

Maybe try another controller of same type to verify if it's a general problem
or linked to the specific piece. Could be an awful hw timing bug only showing
up at full DMA speed...

Regards,
Stephan

