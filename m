Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUIZQjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUIZQjt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 12:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269578AbUIZQjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 12:39:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:31401 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267815AbUIZQjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 12:39:48 -0400
Date: Sun, 26 Sep 2004 09:39:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 8/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation,
 cleanups and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409260847460.18239@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0409260936550.2317@ppc970.osdl.org>
References: <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241714190.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0409240926580.32117@ppc970.osdl.org>
 <Pine.LNX.4.60.0409242059420.5443@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0409241930510.2317@ppc970.osdl.org>
 <20040925072516.GS23987@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0409250834110.2317@ppc970.osdl.org>
 <Pine.LNX.4.60.0409260847460.18239@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Sep 2004, Anton Altaparmakov wrote:
> 
> What does sparse do at the moment when the enum size has been changed 
> away from sizeof(int) using __attribute__ ((__packed__))?

Spatse doesn't support that at all, and will just ignore it.

Of course, since sparse doesn't actually generate any code, there's no 
real impact from that. In theory, you might get sparse to complain if you 
do something like "__attribute__((align(sizeof(xx)))" where the size is 
now wrong and not a power-of-two, but..

		Linus
