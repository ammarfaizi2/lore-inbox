Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTJQNTX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 09:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTJQNTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 09:19:23 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:43712 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S263463AbTJQNTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 09:19:21 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: Transparent compression in the FS
Date: Fri, 17 Oct 2003 15:16:06 +0200
User-Agent: KMail/1.5.4
Cc: val@nmt.edu, linux-kernel@vger.kernel.org
References: <1066163449.4286.4.camel@Borogove> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com>
In-Reply-To: <20031016172930.GA5653@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310171516.06990.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 October 2003 19:29, Larry McVoy wrote:
> On Wed, Oct 15, 2003 at 11:13:27AM -0400, Jeff Garzik wrote:
> > Josh and others should take a look at Plan9's venti file storage method
> > -- archival storage is a series of unordered blocks, all of which are
> > indexed by the sha1 hash of their contents.  This magically coalesces
> > all duplicate blocks by its very nature, including the loooooong runs of
> > zeroes that you'll find in many filesystems.  I bet savings on "all
> > bytes in this block are zero" are worth a bunch right there.
>
> The only problem with this is that you can get false positives.  Val Hensen
> recently wrote a paper about this.  It's really unlikely that you get false
> positives but it can happen and it has happened in the field.

Which is solvable by expanding your index with an enumerator for identical keys
but different content and have an overflow table exactly for this.

Handling hash table overflow is normal for hashing (even for
crypto-hashes). Why did they forget that? That's 2nd semester CS!

Regards

Ingo Oeser


