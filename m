Return-Path: <linux-kernel-owner+w=401wt.eu-S1750772AbXACNhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbXACNhT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 08:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbXACNhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 08:37:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38525 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbXACNhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 08:37:17 -0500
Subject: Re: kernel + gcc 4.1 = several problems
From: Arjan van de Ven <arjan@infradead.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Grzegorz Kulewski <kangur@polcom.net>, Mikael Pettersson <mikpe@it.uu.se>,
       s0348365@sms.ed.ac.uk, torvalds@osdl.org, 76306.1226@compuserve.com,
       akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, yanmin_zhang@linux.intel.com
In-Reply-To: <20070103124410.4cb191dd@localhost.localdomain>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
	 <20070103102944.09e81786@localhost.localdomain>
	 <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net>
	 <20070103124410.4cb191dd@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 03 Jan 2007 05:32:16 -0800
Message-Id: <1167831136.3095.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-03 at 12:44 +0000, Alan wrote:
> > > fixed. At that point an i686 kernel would contain i686 instructions and
> > > actually run on all i686 processors ending all the i586 pain for most
> > > users and distributions.
> > 
> > Could you explain why CMOV is pointless now? Are there any benchmarks 
> > proving that?
> 
> Take a look at the recent ffmpeg bits on the mplayer list for one example
> I have to hand - P4 cmov is pretty slow. The crypto folks find the same
> things.

cmov is effectively the same cost as a compare and jump, in both cases
the cpu needs to do a prediction, and on a mispredict, restart.

the reason cmov can make sense is because it's smaller code...

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

