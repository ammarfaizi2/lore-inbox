Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUEQRkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUEQRkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUEQRkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:40:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8589 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262063AbUEQRkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:40:08 -0400
Date: Mon, 17 May 2004 18:40:04 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Steven Cole <scole@lanl.gov>
Cc: hugh@veritas.com, elenstev@mesatop.com, linux-kernel@vger.kernel.org,
       support@bitmover.com, Linus Torvalds <torvalds@osdl.org>,
       Wayne Scott <wscott@bitmover.com>, adi@bitmover.com, akpm@osdl.org,
       wli@holomorphy.com, lm@bitmover.com, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: 1352 NUL bytes at the end of a page?
Message-ID: <20040517174004.GU17014@parcelfarce.linux.theplanet.co.uk>
References: <200405162136.24441.elenstev@mesatop.com> <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040516231120.405a0d14.akpm@osdl.org> <20040517.085640.30175416.wscott@bitmover.com> <20040517151738.GA4730@thunk.org> <Pine.LNX.4.58.0405170820560.25502@ppc970.osdl.org> <20040517153736.GT17014@parcelfarce.linux.theplanet.co.uk> <E88DCF88-A827-11D8-A7EA-000A95CC3A8A@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E88DCF88-A827-11D8-A7EA-000A95CC3A8A@lanl.gov>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 11:30:36AM -0600, Steven Cole wrote:
 
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
> 0) = 0x40018000

rw anonymous - that has nothing to do with any IO.

> old_mmap(NULL, 19184, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000

read-only, whatever file that was.

Was there anything with PROT_WRITE and without MAP_ANONYMOUS?
