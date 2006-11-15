Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966642AbWKOE5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966642AbWKOE5j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966644AbWKOE5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:57:39 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:59494 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S966642AbWKOE5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:57:38 -0500
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<20061114.190036.30187059.davem@davemloft.net>
	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
	<20061114.192117.112621278.davem@davemloft.net>
	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
	<p73ejs5co0q.fsf@bingen.suse.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 14 Nov 2006 20:57:37 -0800
In-Reply-To: <p73ejs5co0q.fsf@bingen.suse.de> (Andi Kleen's message of "15 Nov 2006 05:49:41 +0100")
Message-ID: <adazmatxq66.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Nov 2006 04:57:37.0327 (UTC) FILETIME=[92119BF0:01C70872]
Authentication-Results: sj-dkim-5; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim5002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > At least AMD (PCI-X) and Serverworks bridges are known broken with MSI
 > They should be both quirked though. Or rather one SVW bridge is quirked
 > there might be more. AMD 8131 is quirked. AMD 8132 is broken too but 
 > should not have the capability structure in the first place.

I thought people had AMD 8132 working?  The only MSI erratum I see for
the 8132 is that a write to the MSI address with all byte-enables
deasserted is bad.  But do any devices really do that?  It seems like
a really odd thing to do.

 - R.
