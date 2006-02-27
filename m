Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWB1O4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWB1O4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 09:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWB1O4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 09:56:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61966 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751160AbWB1O4q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 09:56:46 -0500
Date: Mon, 27 Feb 2006 14:13:16 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert serial_core oopses to BUG_ON
Message-ID: <20060227141315.GD2429@ucw.cz>
References: <20060226100518.GA31256@flint.arm.linux.org.uk> <20060226021414.6a3db942.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060226021414.6a3db942.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 26-02-06 02:14:14, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > Calling serial functions to flush buffers, or try to send more data
> >  after the port has been closed or hung up is a bug in the code doing
> >  the calling, not in the serial_core driver.
> > 
> >  Make this explicitly obvious by adding BUG_ON()'s.
> 
> If we make it
> 
> 	if (!info) {
> 		WARN_ON(1);
> 		return;
> 	}
> 
> will that allow people's kernels to limp along until it gets fixed?

It will oops in hard-to-guess, place, anyway. BUG_ON is right.
-- 
Thanks, Sharp!
