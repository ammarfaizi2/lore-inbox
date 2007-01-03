Return-Path: <linux-kernel-owner+w=401wt.eu-S932139AbXACWML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbXACWML (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbXACWML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:12:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54946 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139AbXACWMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:12:10 -0500
Date: Wed, 3 Jan 2007 14:08:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
cc: Grzegorz Kulewski <kangur@polcom.net>, Alan <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@it.uu.se>, s0348365@sms.ed.ac.uk,
       76306.1226@compuserve.com, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <1167860659.13394.41.camel@unreal>
Message-ID: <Pine.LNX.4.64.0701031351510.4473@woody.osdl.org>
References: <200701030212.l032CDXe015365@harpo.it.uu.se> 
 <20070103102944.09e81786@localhost.localdomain> 
 <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net> 
 <Pine.LNX.4.64.0701030731080.4473@woody.osdl.org> <1167860659.13394.41.camel@unreal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2007, Thomas Sailer wrote:
> 
> IF... Counterexample: Add-Compare-Select in a Viterbi Decoder.

Yes. [De]compression stuff tends to be (a) totally unpredictable and (b) a 
situation where people care about performance. It's fairly rare in many 
other situations.

That said, any real performance these days is about avoiding cache misses. 
There cmov really can help more, if it results in denser code (fairly big 
if, though).

			Linus
