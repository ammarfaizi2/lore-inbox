Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264227AbTFDWO2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 18:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264228AbTFDWO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 18:14:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4998
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264227AbTFDWO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 18:14:26 -0400
Subject: Re: [PATCH] [2.5] Non-blocking write can block
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, "P. Benie" <pjb1008@eng.cam.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306041050250.14593-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0306041050250.14593-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054762191.14033.72.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Jun 2003 22:29:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-04 at 18:57, Linus Torvalds wrote:
> A much better fix might well be to actually not allow over-long tty writes
> at all, and thus avoid the "block out" thing at the source of the problem,
> instead of trying to make programs who play nice be the ones that suffer.
> 
> If somebody does a 1MB write to a tty, do we actually have any reason to 
> try to make it so damn atomic and not return early?

I would be concerned as to what applications rely in the tty write being done
completely before returning. OTOH I can't see any reason we can't drop the
atomicity part without dropping the 1Mb write will eventually write 1Mbyte
property. That would not seem to be a problem unless POSIX says otherwise ?

