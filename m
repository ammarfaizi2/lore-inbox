Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbUDNKCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 06:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264004AbUDNKCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 06:02:12 -0400
Received: from p4.ensae.fr ([195.6.240.202]:18080 "EHLO pc809.ensae.fr")
	by vger.kernel.org with ESMTP id S263567AbUDNKCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 06:02:11 -0400
From: Guillaume =?iso-8859-1?q?Lac=F4te?= <Guillaume@Lacote.name>
Reply-To: Guillaume@Lacote.name
Organization: Guillaume@Lacote.name
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: Using compression before encryption in device-mapper
Date: Wed, 14 Apr 2004 12:02:07 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
References: <200404131744.40098.Guillaume@Lacote.name> <200404140854.56387.Guillaume@Lacote.name> <20040414094334.GA25975@wohnheim.fh-wedel.de>
In-Reply-To: <20040414094334.GA25975@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404141202.07021.Guillaume@Lacote.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Oops ! I thought it was possible to guarantee with the Huffman encoding
> > (which is more basic than Lempev-Zif) that the compressed data use no
> > more than 1 bit for every byte (i.e. 12,5% more space).
>
> Makes sense, although I'd like to see the proof first.  Shouldn't be
> too hard to do.
>
I was referring to the paper by Jeffrey Scott Vitter "Design and Analysis of 
Dynamic Huffman Codes" (accessible through http://acm.org). It defines a 
refinement of the well-known dynamic Huffman algorithm by Faller, Gallager 
and Knuth such that the encoded length will use at most _one_ more bit per 
encoded letter than the optimal two-pass Huffman algorithm (it is also shown 
that the FGK algorithm an use twice the optimal length + on more bit per 
letter).

My conclusion comes from the fact that for every text, the optimal two-pass 
huffman encoding can _not_ be longer than the native encoding (apart from the 
dictionnary encoding). 

Actually I plan to implement the easier FGK algorithm first - if the whole 
matter makes sense.

