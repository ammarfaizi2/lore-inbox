Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWAUWEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWAUWEu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWAUWEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:04:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45195 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932410AbWAUWE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:04:26 -0500
Date: Sat, 21 Jan 2006 17:04:02 -0500
From: Dave Jones <davej@redhat.com>
To: Erwin Rol <mailinglists@erwinrol.com>
Cc: Andrew Morton <akpm@osdl.org>, "Carlo E. Prelz" <fluido@fluido.as>,
       linux-kernel@vger.kernel.org
Subject: Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Message-ID: <20060121220402.GC28051@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Erwin Rol <mailinglists@erwinrol.com>,
	Andrew Morton <akpm@osdl.org>, "Carlo E. Prelz" <fluido@fluido.as>,
	linux-kernel@vger.kernel.org
References: <20060120123202.GA1138@epio.fluido.as> <20060121010932.5d731f90.akpm@osdl.org> <20060121125741.GA13470@epio.fluido.as> <20060121125822.570b0d99.akpm@osdl.org> <1137878926.2976.28.camel@xpc.home.erwinrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137878926.2976.28.camel@xpc.home.erwinrol.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 10:28:46PM +0100, Erwin Rol wrote:
 > I had also had the problem that my Shuttle ST20G5 (a RS480 IGP based
 > system) hung in pci_init. This was with one of the Fedora Rawhide
 > kernels, after reporting it  Dave Jones fixed it cause the next rawhide
 > kernel worked again, maybe he could explain what it was, and where the
 > fix is (if it is the same thing, but it really looks like it).

That was due to us carrying one of the 'make the clock not tick
at twice the speed on ati chipsets' patches. Matthew Garrett's variant iirc.
It worked fine in .14, but caused havoc in .15+

I put it down to the problem being fixed in other ways upstream.

		Dave

