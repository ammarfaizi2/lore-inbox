Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVLDA4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVLDA4L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 19:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVLDA4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 19:56:11 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:60838 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932168AbVLDA4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 19:56:10 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][mm][Fix] swsusp: fix counting of highmem pages
Date: Sun, 4 Dec 2005 01:57:14 +0100
User-Agent: KMail/1.8.3
Cc: Andy Isaacson <adi@hexapodia.org>, LKML <linux-kernel@vger.kernel.org>
References: <200512032140.15192.rjw@sisk.pl> <200512040126.14048.rjw@sisk.pl> <20051204003546.GF5198@elf.ucw.cz>
In-Reply-To: <20051204003546.GF5198@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512040157.15308.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 4 of December 2005 01:35, Pavel Machek wrote:
> > > >  		}
> > > > +	if (n > 0)
> > > > +		n += (n * KMALLOC_SIZE + PAGE_SIZE - 1) / PAGE_SIZE + 1;
> > > >  	return n;
> > > >  }
> > > 
> > > Can't you just n += n/50 here? Playing with KMALLOC_SIZE knows way too
> > > much about memory allocation details.
> > 
> > I do the "n + n/50" later on, so I can just drop all of the above changes
> > if they are too complicated.
> 
> Yes, that would be nice.

OK

In which case I'll have only two changes fixing two different problems,
so I think they should go each in a separate patch.  Would that be ok?

Rafael
