Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267952AbTHKQj1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272752AbTHKQj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:39:27 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:1617 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S267952AbTHKQjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:39:11 -0400
Date: Mon, 11 Aug 2003 17:38:34 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: torvalds@transmeta.com, fxkuehl@gmx.de, linux-kernel@vger.kernel.org,
       willy@w.ods.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] Disable APIC on reboot.
Message-ID: <20030811163834.GA21568@redhat.com>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Mikael Pettersson <mikpe@csd.uu.se>, torvalds@transmeta.com,
	fxkuehl@gmx.de, linux-kernel@vger.kernel.org, willy@w.ods.org,
	marcelo@conectiva.com.br
References: <E19mCuO-0003dI-00@tetrachloride> <16183.50273.723650.136532@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16183.50273.723650.136532@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 06:29:21PM +0200, Mikael Pettersson wrote:
 > I agree we should probably disable the local APIC at reboot if we
 > enabled it previously, but this patch is broken. CONFIG_X86_LOCAL_APIC
 > doesn't imply that the CPU actually has one, and even if it does, the
 > access method may be different (e.g. P5 vs P6/K7/P4, and who knows how
 > the future C3 with local APIC will do it).

Ok. The original poster mentioned that disable_local_apic() didn't
do the right thing there, hence the duplication, so making that DTRT
may make sense ?

 > Was the original bug report posted to LKML? I don't remember seeing it.

Yes. I'll bounce it to you.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
