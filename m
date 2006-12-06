Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760565AbWLFMpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760565AbWLFMpQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 07:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760562AbWLFMpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 07:45:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46293 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760565AbWLFMpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 07:45:14 -0500
Subject: Re: Why is "Memory split" Kconfig option only for EMBEDDED?
From: Arjan van de Ven <arjan@infradead.org>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1165407548.5954.224.camel@titan.tbdnetworks.com>
References: <1165405350.5954.213.camel@titan.tbdnetworks.com>
	 <1165406299.3233.436.camel@laptopd505.fenrus.org>
	 <1165407548.5954.224.camel@titan.tbdnetworks.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 06 Dec 2006 13:45:12 +0100
Message-Id: <1165409112.3233.441.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-06 at 13:19 +0100, Norbert Kiesel wrote:
> On Wed, 2006-12-06 at 12:58 +0100, Arjan van de Ven wrote:
> > On Wed, 2006-12-06 at 12:42 +0100, Norbert Kiesel wrote:
> > > Hi,
> > > 
> > > I remember reading on LKML some time ago that using VMSPLIT_3G_OPT would
> > > be optimal for a machine with exactly 1GB memory (like my current
> > > desktop). Why is that option only prompted for after selecting EMBEDDED
> > > (which I normally don't select for desktop machines
> > 
> > because it changes the userspace ABI and has some other caveats.... this
> > is not something you should muck with lightly 
> > 
> 
> Hmm, but it's also marked EXPERIMENTAL. Would that not be the
> sufficient?  Assuming I don't use any external/binary drivers and a
> self-compiled kernel w//o any additional patches: is there really any
> downside?

I said *userspace ABI*. You're changing something that userspace has
known about and was documented since the start of Linux. So userspace
application binaries can break, and at least you're changing the rules
on them. That's fine if you know what you're doing.. but in a general
system... not a good default, hence the EMBEDDED.


I assumed entirely that you're not using binary drivers, those are just
horrid in the first place :)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

