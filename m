Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbUDNLZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 07:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbUDNLZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 07:25:19 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:60837 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264040AbUDNLZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 07:25:14 -0400
Date: Wed, 14 Apr 2004 13:25:06 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Guillaume =?iso-8859-1?Q?Lac=F4te?= <Guillaume@lacote.name>
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
Message-ID: <20040414112506.GB25975@wohnheim.fh-wedel.de>
References: <200404131744.40098.Guillaume@Lacote.name> <200404140854.56387.Guillaume@Lacote.name> <20040414094334.GA25975@wohnheim.fh-wedel.de> <200404141202.07021.Guillaume@Lacote.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200404141202.07021.Guillaume@Lacote.name>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 April 2004 12:02:07 +0200, Guillaume Lacôte wrote:
> 
> > > Oops ! I thought it was possible to guarantee with the Huffman encoding
> > > (which is more basic than Lempev-Zif) that the compressed data use no
> > > more than 1 bit for every byte (i.e. 12,5% more space).
> >
> > Makes sense, although I'd like to see the proof first.  Shouldn't be
> > too hard to do.
> >
> I was referring to the paper by Jeffrey Scott Vitter "Design and Analysis of 
> Dynamic Huffman Codes" (accessible through http://acm.org). It defines a 
> refinement of the well-known dynamic Huffman algorithm by Faller, Gallager 
> and Knuth such that the encoded length will use at most _one_ more bit per 
> encoded letter than the optimal two-pass Huffman algorithm (it is also shown 
> that the FGK algorithm an use twice the optimal length + on more bit per 
> letter).
> 
> My conclusion comes from the fact that for every text, the optimal two-pass 
> huffman encoding can _not_ be longer than the native encoding (apart from the 
> dictionnary encoding). 

Makes sense.  You should try to use the crypto/ infrastructure in the
kernel, add the compression algorithm there and use it through the
normal interface.  Apart from that, good lock! :)

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
