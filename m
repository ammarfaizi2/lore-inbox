Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVDKVft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVDKVft (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 17:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVDKVft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 17:35:49 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:25780 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261953AbVDKVfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 17:35:43 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Date: Mon, 11 Apr 2005 23:35:38 +0200
User-Agent: KMail/1.7.1
Cc: Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <4259B474.4040407@domdv.de> <200504112257.39708.rjw@sisk.pl> <20050411210819.GF23530@elf.ucw.cz>
In-Reply-To: <20050411210819.GF23530@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504112335.39155.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 11 of April 2005 23:08, Pavel Machek wrote:
> Hi!
> 
]--snip--[
> > > @@ -130,6 +150,52 @@
> > >  static unsigned short swapfile_used[MAX_SWAPFILES];
> > >  static unsigned short root_swap;
> > >  
> > > +#ifdef CONFIG_SWSUSP_ENCRYPT
> > > +static struct crypto_tfm *crypto_init(int mode)
> > 
> > I think it's better if this function returns an int error code and the
> > messages are printed where it's called from.  This way, the essential
> > part of the code would be easier to grasp (Pavel?).
> 
> Agreed. Actually I do not care where messages are printed, but
> returning different code for different errors seems right.

Hm.  You probably don't want suspend-related messages to be printed during
resume (this function is called in two different places)? :-)

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
