Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132541AbRAZPfu>; Fri, 26 Jan 2001 10:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132546AbRAZPfl>; Fri, 26 Jan 2001 10:35:41 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:61455 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S132541AbRAZPf3>; Fri, 26 Jan 2001 10:35:29 -0500
Date: Fri, 26 Jan 2001 16:34:30 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: James Sutherland <jas88@cam.ac.uk>, "David S. Miller" <davem@redhat.com>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010126163430.G7096@pcep-jamie.cern.ch>
In-Reply-To: <14961.33191.626833.945221@pizda.ninka.net> <Pine.SOL.4.21.0101261506240.16539-100000@red.csi.cam.ac.uk> <20010126161338.N3849@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010126161338.N3849@marowsky-bree.de>; from lmb@suse.de on Fri, Jan 26, 2001 at 04:13:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree wrote:
> If connect() suddenly did two connection attempts instead of one, just how
> many timeouts might that break?

Timeouts are already broken by applications that repeatedly call
connect().  You'd get better timeout behaviour by letting the kernel
enforce backoff.

> > Why? The connection is dead, but there is nothing to prevent attempting
> > another connection.
> 
> Right. And thats why connect() returns an error and retries are handled in
> userspace.

And this is fine.  Can we be permitted to handle a retry in userspace
without fancy options (ECN, SACK, large windows etc.)?

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
