Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267890AbRG3Ut5>; Mon, 30 Jul 2001 16:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267837AbRG3Uts>; Mon, 30 Jul 2001 16:49:48 -0400
Received: from ns.caldera.de ([212.34.180.1]:55725 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S267885AbRG3Ute>;
	Mon, 30 Jul 2001 16:49:34 -0400
Date: Mon, 30 Jul 2001 22:49:31 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010730224930.A18311@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200107281645.f6SGjA620666@ns.caldera.de> <3B653211.FD28320@namesys.com> <20010730210644.A5488@caldera.de> <3B65C3D4.FF8EB12D@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B65C3D4.FF8EB12D@namesys.com>; from reiser@namesys.com on Tue, Jul 31, 2001 at 12:30:12AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 12:30:12AM +0400, Hans Reiser wrote:
> But there is not one where they recover from invalid arguments without a panic
> (unless I failed to notice something),

Right.

> so it gets you nothing except a message
> that we the developers will find more informative when trying to find what made
> it crash.

Nope.  It does a reiserfs_panic instead of letting the wrong arguments
slipping into lower layers and possibly on disk and thus corrupting data.

And in my opinion correct data is much more worth than one crash more or
less (especially with a journaling filesystem).

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
