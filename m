Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUINXYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUINXYT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUINXYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:24:15 -0400
Received: from hera.cwi.nl ([192.16.191.8]:58014 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S267312AbUINXVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 19:21:25 -0400
Date: Wed, 15 Sep 2004 01:21:16 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [no patch] broken use of mm_release / deactivate_mm
Message-ID: <20040914232116.GA14580@apps.cwi.nl>
References: <20040913190633.GA22639@apps.cwi.nl> <Pine.LNX.4.58.0409131224440.2378@ppc970.osdl.org> <4146E6F0.5030405@yahoo.com.au> <Pine.LNX.4.58.0409140803090.2378@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409140803090.2378@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 08:06:14AM -0700, Linus Torvalds wrote:

> Does everybody also agree that ... mmput() does all of that correctly too?

I think so, but do not have time to check all details.


Now the first parameter of mm_release() always is current,
so that this parameter is superfluous. Similarly, the only
parameter of exit_mm() always is current, and hence is superfluous.

Maybe it is a good idea to remove the pretense that these routines
might do something useful for general parameters, now that
deactivate_mm() does sneaky global things.

Andries

