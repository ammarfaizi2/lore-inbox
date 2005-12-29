Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVL2QVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVL2QVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVL2QVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:21:33 -0500
Received: from cantor2.suse.de ([195.135.220.15]:39057 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750796AbVL2QVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:21:33 -0500
To: Erez Zilber <erezz@voltaire.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: cannot boot 2.6.15-rc6 on Opteron machine
References: <43B3CA9E.7000804@voltaire.com>
	<1135857022.2935.19.camel@laptopd505.fenrus.org>
	<43B3D8D3.30400@voltaire.com>
	<1135861619.2935.35.camel@laptopd505.fenrus.org>
	<43B3E107.6090104@voltaire.com>
From: Andi Kleen <ak@suse.de>
Date: 29 Dec 2005 17:21:27 +0100
In-Reply-To: <43B3E107.6090104@voltaire.com>
Message-ID: <p73slsbg9h4.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erez Zilber <erezz@voltaire.com> writes:
> >
> So, I understand that, currently (until I get a a recent enough udev),
> 2.6.15 cannot be used with RHAS-4 on Opteron machines. Anyway, thanks
> for your help.

I think that's too strong. udev setups are fragile and seem 
to be inventented by the devil to make kernel updates hell, but if you
just compile the needed drivers and file systems for root statically 
into the kernel it should work.  For network devices and other
drivers not needed for root you can either load them manually
early in a rc.d file or also compile them in.
 
Typically when udev goes wrong it just doesn't autoload the modules,
but still processes the events when devices appear.

-Andi
