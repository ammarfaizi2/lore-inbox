Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWAPGhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWAPGhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 01:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWAPGhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 01:37:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29658 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751054AbWAPGhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 01:37:00 -0500
Date: Mon, 16 Jan 2006 01:36:53 -0500
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git breaks Xorg on em64t
Message-ID: <20060116063653.GA3112@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@gmail.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060114065235.GA4539@redhat.com> <200601141943.28027.ak@suse.de> <20060114225137.GB23021@redhat.com> <200601150105.08197.ak@suse.de> <20060115070658.GB6454@redhat.com> <21d7e9970601150136m25ef428es139a641e2619997@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970601150136m25ef428es139a641e2619997@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 08:36:05PM +1100, Dave Airlie wrote:
 > >
 > > Another datapoint btw: I've another EM64T that works just fine.
 > > The one that fails is the only one that isn't using onboard VGA,
 > > this one has a PCIE Radeon.  Given it happens when X is starting up,
 > > it could be that the X radeon driver does something special which
 > > is why others aren't seeing this.
 > >
 > 
 > It might be due to the DRM update that went through, but I can't think
 > what might have caused it, if you backout the DRM merge does it help
 > any?

As it turns out, -git11 with all the DRM bits backed out gives me
a working X again.

 > did the previous kernel have DRM support for that card?

No. This is 1002:5b60 / 1002:5b70 based card.

I had previously missed the 5b60 part in lspci output, so thinking
there was no 5b70 addition, I hadn't considered this as a suspect.
Mea Culpa.   Looks like Andi is off the hook :-)

Any ideas for any debugging I can add ?

		Dave

