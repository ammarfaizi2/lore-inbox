Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUF1WJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUF1WJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUF1WJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:09:53 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:27707 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265256AbUF1WJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:09:38 -0400
Date: Mon, 28 Jun 2004 17:09:10 -0500 (CDT)
From: Pat Gefre <pfg@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Pat Gefre <pfg@sgi.com>, erikj@subway.americas.sgi.com,
       rmk+lkml@arm.linux.org.uk, cw@f00f.org, hch@infradead.org,
       jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
In-Reply-To: <20040628121312.75ac9ed7.akpm@osdl.org>
Message-ID: <Pine.SGI.3.96.1040628170609.36430N-100000@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004, Andrew Morton wrote:

+ Pat Gefre <pfg@sgi.com> wrote:
+ >
+ > We think we should stick with the major/minor set we have proposed.  We
+ >  don't like hacking the 8250 code, dynamic allocation doesn't work (once
+ >  that works we will update our driver to use it), registering for our
+ >  own major/minor may not work (if we DO get one we will update the
+ >  driver to reflect it) but in the meantime we need to get something in
+ >  the community that works.
+ 
+ "we don't like" isn't a very strong argument ;)
+ 
+ It does sound to me like some work is needed in the generic serial layer to
+ teach it to get its sticky paws off the ttyS0 major/minor if there is no
+ corresponding hardware.  AFAICT nobody has scoped out exactly what has to
+ be done for a clean solution there - it may not be very complex.  So could
+ we please explore that a little further?
+ 
+ If that proves to be impractical for some reason then I'd be inclined to
+ allocate a new misc minor, stick it in devices.txt and be done with it.

I'm not sure I understand what you mean by this. Use a different major
(one that is likely to not be used by anyone else on our system) and a
minor that no one is assigned ?

-- Pat

