Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272402AbTHSS2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272324AbTHSSZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:25:57 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:26634 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S272671AbTHSSQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:16:40 -0400
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA bus update
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <wrp3cfxn78n.fsf@hina.wild-wind.fr.eu.org>
	<20030819174208.GA4992@kroah.com>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Tue, 19 Aug 2003 20:16:12 +0200
Message-ID: <wrpptj1fr83.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030819174208.GA4992@kroah.com> (Greg KH's message of "Tue,
 19 Aug 2003 10:42:08 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

Greg,

Greg> Marc, why do you think that you do not need to do anything in
Greg> this function?  Don't you need to handle the fact that your code
Greg> could be removed before the release function is called?

Well, there is nothing to do in this function, because that's what the
whole driver does: nothing. It just presents a range of IO ports to be
probed to the main EISA code, and nothing else.

If the driver is removed from the kernel (which can't happen at the
moment, since it is not modular), it doesn't matter... Once it has
registered as an EISA bus root, it doesn't get called anymore, the
core code does it all by itself.

So no, I truly don't think there's anything to do in this release
function.

Regards,

	M.
-- 
Places change, faces change. Life is so very strange.
