Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbTEOPDF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264062AbTEOPDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:03:04 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:29602 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264061AbTEOPDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:03:03 -0400
Date: Thu, 15 May 2003 16:16:33 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: kraxel@suse.de, jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
Message-ID: <20030515151633.GA6128@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andi Kleen <ak@muc.de>, kraxel@suse.de, jsimmons@infradead.org,
	linux-kernel@vger.kernel.org
References: <20030515145640.GA19152@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515145640.GA19152@averell>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 04:56:40PM +0200, Andi Kleen wrote:

 > x86-64 cannot call the 32bit VESA BIOS. This means when vesafb is active
 > it does software copying in the vesa frame buffer. This is insanely slow
 > when the frame buffer is not marked for write combining. 
 > 
 > Some discussion showed that the use_mtrr flag was only off for some 
 > old broken ET4000 ISA card. x86-64 has no ISA, so this is no concern.
 > Make the default depend on CONFIG_ISA. 

There are PCI ET4000's too.  Though if we can get the PCI IDs for those,
we can work around them with a quirk.  I have one *somewhere*, but it'll
take me a while to dig it out.

		Dave

