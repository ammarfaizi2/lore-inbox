Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966648AbWKOFLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966648AbWKOFLS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 00:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966650AbWKOFLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 00:11:18 -0500
Received: from mx1.suse.de ([195.135.220.2]:57553 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S966648AbWKOFLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 00:11:18 -0500
From: Andi Kleen <ak@suse.de>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Date: Wed, 15 Nov 2006 06:11:13 +0100
User-Agent: KMail/1.9.5
Cc: Linus Torvalds <torvalds@osdl.org>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org> <p73ejs5co0q.fsf@bingen.suse.de> <adazmatxq66.fsf@cisco.com>
In-Reply-To: <adazmatxq66.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611150611.13623.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 05:57, Roland Dreier wrote:
>  > At least AMD (PCI-X) and Serverworks bridges are known broken with MSI
>  > They should be both quirked though. Or rather one SVW bridge is quirked
>  > there might be more. AMD 8131 is quirked. AMD 8132 is broken too but 
>  > should not have the capability structure in the first place.
> 
> I thought people had AMD 8132 working?  The only MSI erratum I see for
> the 8132 is that a write to the MSI address with all byte-enables
> deasserted is bad.  But do any devices really do that?  It seems like
> a really odd thing to do.

Perhaps with special user space quirks, but not in mainline kernel because it's
not force enabled (see erratum #78).

-Andi
