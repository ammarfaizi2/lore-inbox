Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264533AbTEKAU1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 20:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbTEKAU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 20:20:27 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:63646 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264533AbTEKAU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 20:20:26 -0400
Date: Sun, 11 May 2003 01:32:53 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: TRIVIAL: turn of AGP drivers which are not supported on ia64
Message-ID: <20030511003253.GA29343@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	David Woodhouse <dwmw2@infradead.org>, davidm@hpl.hp.com,
	linux-kernel@vger.kernel.org
References: <200305100953.h4A9rnV8012151@napali.hpl.hp.com> <1052600952.1881.13.camel@lapdancer.baythorne.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052600952.1881.13.camel@lapdancer.baythorne.internal>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 10:09:12PM +0100, David Woodhouse wrote:
 > On Sat, 2003-05-10 at 10:53, David Mosberger wrote:
 > >  #config AGP_I810
 > >  #	tristate "Intel I810/I815/I830M (on-board) support"
 > > -#	depends on AGP && !X86_64
 > > +#	depends on AGP && !X86_64 && !IA64
 > 
 > ... it works on Alpha? Should this be 'AGP && i386' instead?

Actually current agpgart bk has
depends on AGP && X86 && !X86_64

which should get things right on all archs..

		Dave

