Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVADQM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVADQM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVADQKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:10:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9485 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261707AbVADQGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:06:41 -0500
Date: Tue, 4 Jan 2005 16:06:37 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
       Vincent Sanders <vince@simtec.co.uk>
Subject: Re: [PATCH 1/2] AC97 plugin suspend/resume
Message-ID: <20050104160637.C22890@flint.arm.linux.org.uk>
Mail-Followup-To: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	lkml <linux-kernel@vger.kernel.org>,
	Vincent Sanders <vince@simtec.co.uk>
References: <1104850243.9143.333.camel@cearnarfon> <20050104151911.B22890@flint.arm.linux.org.uk> <1104854148.9143.377.camel@cearnarfon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1104854148.9143.377.camel@cearnarfon>; from Liam.Girdwood@wolfsonmicro.com on Tue, Jan 04, 2005 at 03:55:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 03:55:48PM +0000, Liam Girdwood wrote:
> On Tue, 2005-01-04 at 15:19, Russell King wrote:
> > Liam,
> > 
> > Please consider giving credit where credit is due.  Thanks.
> 
> Sorry Russell,
> 
> I had no idea who in the group had originally made the change since
> yourself and Vince were accepting the kernel patches. I thought it would
> be better to submit it signed rather than unsigned. 
> 
> Please let me know who is responsible and if it's ok, I'll then
> re-submit.

Yours truely is responsible for this code change - it was committed
into "that" CVS tree with these comments originally:

Reference: 13-wm97xx/03-ac97-pm

- Add suspend/resume methods to the ac97 codec plugin driver structure.
- Add code to ac97_codec to allow these methods to be safely called for
  the specified codec.
- Convert ac97_plugin_wm97xx to use these two pointers for its suspend
  and resume hooks.
- Modify pxa-ac97 to call the new ac97_codec suspend/resume functions.

so what you have there is a cut down version of this patch.

If you want an archive of the cvs commit messages for "that" CVS tree,
I can throw you a copy.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
