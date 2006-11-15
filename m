Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966641AbWKOEtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966641AbWKOEtn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966642AbWKOEtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:49:43 -0500
Received: from mail.suse.de ([195.135.220.2]:43981 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S966641AbWKOEtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:49:43 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<20061114.190036.30187059.davem@davemloft.net>
	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
	<20061114.192117.112621278.davem@davemloft.net>
	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 15 Nov 2006 05:49:41 +0100
In-Reply-To: <Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
Message-ID: <p73ejs5co0q.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
> 
> But right now I'm not convinced we really know what all goes wrong. Maybe 
> it's just broken NVidia and AMD bridges.

At least AMD (PCI-X) and Serverworks bridges are known broken with MSI
They should be both quirked though. Or rather one SVW bridge is quirked
there might be more. AMD 8131 is quirked. AMD 8132 is broken too but 
should not have the capability structure in the first place.

BTW there seems to be a new ACPI FADT bit that says "MSI is broken"
We should probably check that too as a double check.

-Andi
