Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932998AbWJISWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998AbWJISWi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 14:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932997AbWJISWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 14:22:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14000 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932998AbWJISWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 14:22:37 -0400
Subject: Re: [PATCH] [kernel/ subdirectory] constifications
From: Arjan van de Ven <arjan@infradead.org>
To: Helge Deller <deller@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200610092016.18362.deller@gmx.de>
References: <200610082121.49925.deller@gmx.de>
	 <1160377169.3000.189.camel@laptopd505.fenrus.org>
	 <200610092016.18362.deller@gmx.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 09 Oct 2006 20:22:34 +0200
Message-Id: <1160418154.3000.244.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 20:16 +0200, Helge Deller wrote:
> On Monday 09 October 2006 08:59, Arjan van de Ven wrote:
> > On Sun, 2006-10-08 at 21:21 +0200, Helge Deller wrote:
> > > - completely constify string arrays,  thus move them to the rodata section
> > 
> > note that gcc 4.1 and later will do this automatically for static things
> > at least...
> 
> Are you sure ?
> 
> At least with gcc-4.1.0 from SUSE 10.1 the strings array _pointers_ are not moved into the rodata section without the second "const":
> const static char * const x[] = { "value1", "value2" };
> 

hmm I could have sworn GCC does this automatic nowadays as long as it
can prove you're not writing to the thing (eg static and not passing the
pointer to some external function).....

(even if gcc does this perfect I'm still in favor of the explicit const,
just to catch stupid code with a warning)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

