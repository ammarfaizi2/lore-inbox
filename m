Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbTJPRlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 13:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbTJPRlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 13:41:32 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52107
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262909AbTJPRlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 13:41:31 -0400
Date: Thu, 16 Oct 2003 19:41:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Josh Litherland <josh@temp123.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031016174153.GI1663@velociraptor.random>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <3F8ED0FC.9070706@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8ED0FC.9070706@pobox.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 01:10:20PM -0400, Jeff Garzik wrote:
> As Andre H and Larry McVoy love to point out, data isn't _really_ secure 
> until it's been checksummed, and that checksum data is verified on 
> reads.  LM has an anecdote (doesn't he always?  <g>) about how BitKeeper 
> -- which checksums its data inside the app -- has found data-corrupting 
> kernel bugs, in days long past.

yes, even a fs checksum won't protect against kernel bugs randomly
corrupting pagacache, and that's why having it in userspace is
preferable IMHO (though in userspace it's more difficult to switch it
off transparently unless the app is designed for that).
