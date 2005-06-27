Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVF0XY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVF0XY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVF0XUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:20:25 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:41191 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262123AbVF0XSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:18:23 -0400
Date: Tue, 28 Jun 2005 01:20:27 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, bunk@stusta.de
Message-ID: <20050627232027.GB8701@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	bunk@stusta.de
References: <20050627120600.739151000@abc> <20050627121413.689826000@abc> <20050627155403.70e2d77d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627155403.70e2d77d.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.203.165
Subject: Re: [DVB patch 21/51] ttusb-dec: kfree cleanup
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Johannes Stezenbach <js@linuxtv.org> wrote:
> >
> > From: Adrian Bunk <bunk@stusta.de>
> > 
> > The Coverity checker discovered that these two kfree's can never be
> > executed.
> > 
> 
> That's a bit strange - the code was OK beforehand.  It's a bit of a tossup.

Hm, the comment was a bit misleading, but the kfree(NULL) is a no-op.

> >  	/* allocate memory for the internal state */
> >  	state = (struct ttusbdecfe_state*) kmalloc(sizeof(struct ttusbdecfe_state), GFP_KERNEL);
> 
> This typecast is unneeded btw.  We tend to avoid casts to and from void*
> because they defeat typechecking and uglify things.

I just passed the patch on unchanged. The void-cast cleanup is for
another patch (the issue is known and we already cleaned up quite
a lot of them).

Johannes
