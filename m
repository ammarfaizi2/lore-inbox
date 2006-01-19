Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWASJd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWASJd6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWASJd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:33:58 -0500
Received: from isilmar.linta.de ([213.239.214.66]:7054 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751381AbWASJd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:33:57 -0500
Date: Thu, 19 Jan 2006 10:33:55 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Wireless issues (was Re: 2.6.16-rc1-mm1)
Message-ID: <20060119093355.GA18026@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060118005053.118f1abc.akpm@osdl.org> <200601182229.k0IMTJ56003467@turing-police.cc.vt.edu> <20060118145619.4b5c7a3a.akpm@osdl.org> <200601190734.k0J7Y6i5004199@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601190734.k0J7Y6i5004199@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 19, 2006 at 02:33:39AM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 18 Jan 2006 14:56:19 PST, Andrew Morton said:
> 
> > There are orinoco changes in git-pcmcia.patch.  Could you try reverting
> > add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch and then
> > git-pcmcia.patch?
> 
> It turns out that we lost the initialization for the 'config_info_t conf;', so
> the compare to conf.Vcc was broken.  Here's a works-for-me patch.

Sorry about that, I accidentally removed this in orinoco_cs and spectrum_cs
where it is still needed, while the removal is safe in many other places.
git-pcmcia will be updated accordingly (i.e. with the initialization not
being removed in the first place) soon.

Many thanks,
	Dominik
