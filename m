Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTJQAqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 20:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbTJQAqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 20:46:10 -0400
Received: from 12-235-58-121.client.attbi.com ([12.235.58.121]:22034 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263201AbTJQAqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 20:46:09 -0400
Date: Thu, 16 Oct 2003 17:45:14 -0700
From: Christopher Li <lkml@chrisli.org>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031017004514.GA6279@64m.dyndns.org>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016230448.GA29279@pegasys.ws>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The idea of this sort of block level hashing to allow
> sharing of identical blocks seems attractive but i wouldn't
> trust any design that did not accept as given that there
> would be false positives.  This means that a write would
> have to not only hash the block but then if there is a
> collision do a compare of the raw data.  Then you have to
> add the overhead of having lists of blocks that match a hash
> value and reference counts for each block itself.  Further,

Then write every data block will need to dirty at least 2 blocks.
And it also need to read back the original block if hash exist.
There must be some performance hit. 

Chris
