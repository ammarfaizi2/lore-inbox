Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbTJPVSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 17:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbTJPVSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 17:18:49 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:57286 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S263050AbTJPVSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 17:18:48 -0400
Subject: Re: Transparent compression in the FS
From: Chris Meadors <clubneon@hereintown.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F8F0766.30405@pobox.com>
References: <1066163449.4286.4.camel@Borogove>
	 <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com>
	 <20031016162926.GF1663@velociraptor.random>
	 <20031016172930.GA5653@work.bitmover.com>
	 <20031016174927.GB25836@speare5-1-14>  <3F8F0766.30405@pobox.com>
Content-Type: text/plain
Message-Id: <1066339127.3958.8.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 16 Oct 2003 17:18:47 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AAFWB-00083F-KL*VHbcUnjsX9s*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-16 at 17:02, Jeff Garzik wrote:

> I'm curious if anyone has done any work on using multiple different 
> checksums?  For example, the cost of checksumming a single block with 
> multiple algorithms (sha1+md5+crc32 for a crazy example), and storing 
> each checksum (instead of just one sha1 sum), may be faster than reading 
> the block off of disk to compare it with the incoming block.  OTOH, 
> there is still a mathematical possibility (however-more-remote) of a 
> collission...

I don't think multiple hashes will gain any more uniqueness over just a
larger hash value.  But as long as the hash is smaller than the block
being hashed there is the possibility of two dissimilar blocks producing
the same hash.

-- 
Chris

