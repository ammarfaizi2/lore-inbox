Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUHYXDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUHYXDx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUHYXCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:02:53 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:37575
	"EHLO nocona.random") by vger.kernel.org with ESMTP id S266128AbUHYXAF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:00:05 -0400
Date: Thu, 26 Aug 2004 00:59:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christophe Saout <christophe@saout.de>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825225933.GD5618@nocona.random>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <1093467601.9749.14.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093467601.9749.14.camel@leto.cs.pocnet.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 11:00:00PM +0200, Christophe Saout wrote:
> It should be completely forbidden to link into a meta-directory or out
> of such a directory. [..]

agreed.

> Yes, I don't think it was a good idea either. Probably someone should

I personally would like plugins only if the API they use wouldn't allow
them to corrupt the underlying fs, I'm not sure if this is the case with
reiserfs4.

About the backwards compatibility, another option is to add a O_FILEDIR
and have bash learn about it when you cd into a file. No magic with the
slashes then.
