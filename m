Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263438AbTJQOcV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 10:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbTJQOcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 10:32:21 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:61352 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263438AbTJQOcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 10:32:20 -0400
Date: Fri, 17 Oct 2003 16:31:30 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Val Henson <val@nmt.edu>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031017143130.GA31872@wohnheim.fh-wedel.de>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <3F8F0766.30405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F8F0766.30405@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 October 2003 17:02:30 -0400, Jeff Garzik wrote:
> 
> I'm curious if anyone has done any work on using multiple different 
> checksums?  For example, the cost of checksumming a single block with 
> multiple algorithms (sha1+md5+crc32 for a crazy example), and storing 
> each checksum (instead of just one sha1 sum), may be faster than reading 
> the block off of disk to compare it with the incoming block.  OTOH, 
> there is still a mathematical possibility (however-more-remote) of a 
> collission...

Would be interesting.  The underlying assumptions of compare-by-hash
are a) a cryptologically strong hash and b) a sufficient hash space.
Since noone has proven a) yet for any hash, it is necessary to store
multiple hashes and just ignore one of them as soon as that particular
hash is proven to be weak.

As a side-effect, you could search for hash collisions this way.  A
new block that has the same md5 hash as some other, but a new sha1 and
crc32 hash tells you a lot. :)

Jörn

-- 
This above all: to thine own self be true.
-- Shakespeare
