Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264234AbUDNNes (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 09:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbUDNNes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 09:34:48 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:38327 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264234AbUDNNeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 09:34:44 -0400
Date: Wed, 14 Apr 2004 15:34:36 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Guillaume@lacote.name, linux-kernel@vger.kernel.org, Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
Message-ID: <20040414133436.GC6955@wohnheim.fh-wedel.de>
References: <200404131744.40098.Guillaume@Lacote.name> <200404140854.56387.Guillaume@Lacote.name> <20040414094334.GA25975@wohnheim.fh-wedel.de> <200404141202.07021.Guillaume@Lacote.name> <407D3231.2080605@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <407D3231.2080605@grupopie.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 April 2004 13:44:33 +0100, Paulo Marques wrote:
> Guillaume Lacôte wrote:
> 
> >>>Oops ! I thought it was possible to guarantee with the Huffman encoding
> >>>(which is more basic than Lempev-Zif) that the compressed data use no
> >>>more than 1 bit for every byte (i.e. 12,5% more space).
> 
> WTF??
> 
> Zlib gives a maximum increase of 0.1%  + 12 bytes (from the zlib manual), 
> which for a 512 block will be a 2.4% guaranteed increase.
> 
> I think that zlib already does the "if this is bigger than original, just 
> mark the block type as uncompressed" algorithm internally, so the increase 
> is minimal in the worst case.

Correct, but Guillaume doesn't care about compression efficiency.
"mark the block uncompressed" is precisely what he does *not* want,
unless I got him wrong.

Jörn

-- 
...one more straw can't possibly matter...
-- Kirby Bakken
