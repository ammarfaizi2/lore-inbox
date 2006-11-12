Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753251AbWKLVr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbWKLVr0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 16:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbWKLVrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 16:47:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4739 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753251AbWKLVrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 16:47:24 -0500
Date: Sun, 12 Nov 2006 16:45:40 -0500
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com,
       ak@suse.de
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
Message-ID: <20061112214540.GB31649@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	David Howells <dhowells@redhat.com>,
	Neil Brown <neilb@cse.unsw.edu.au>,
	"bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>,
	linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com,
	ak@suse.de
References: <20061111100038.6277efd4.akpm@osdl.org> <1163268603.3293.45.camel@laptopd505.fenrus.org> <20061111101942.5f3f2537.akpm@osdl.org> <1163332237.3293.100.camel@laptopd505.fenrus.org> <20061112125357.GH25057@stusta.de> <1163337376.3293.120.camel@laptopd505.fenrus.org> <20061112133759.GK25057@stusta.de> <1163339868.3293.126.camel@laptopd505.fenrus.org> <20061112141016.GA5297@stusta.de> <1163340998.3293.131.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163340998.3293.131.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 03:16:38PM +0100, Arjan van de Ven wrote:
 > 
 > > > We KNOW it can't work on a sizable amount of machines.  This is why it
 > > > is a config option; you can enable it if YOUR machine is KNOWN to work,
 > > > and you get some gains. But it's also understood that it often it won't
 > > > work. So any sensible distro (since they have to aim for a wide
 > > > audience) disables this option ...
 > > 
 > > Nowadays, many distributions only ship CONFIG_SMP=y kernels...
 > 
 > that's a calculated risk on their side (and they know that); they're
 > balancing not functioning on a set of machines off against needing more
 > kernels.

Andi has a nice patch in the suse kernel which adds heuristics to disable
apic on systems where it isn't likely to work.  It DTRT in at least
one problem case that I know of.   The actual fall-out from enabling
'run SMP kernels on UP i686' for FC6 has mostly been a non-event.
Literally a handful of cases, that will likely all get caught and worked
around by Andi's patch or similar.

		Dave

-- 
http://www.codemonkey.org.uk
