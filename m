Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWAJAZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWAJAZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWAJAZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:25:30 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:62642 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932081AbWAJAZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:25:29 -0500
Date: Tue, 10 Jan 2006 00:25:24 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Andreas Gruenbacher <agruen@suse.de>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 0/2] Tmpfs acls
Message-ID: <20060110002523.GA22820@srcf.ucam.org>
References: <200601090023.16956.agruen@suse.de> <E1Evk3m-00043Y-00@chiark.greenend.org.uk> <200601100059.47317.agruen@suse.de> <20060110000758.GA22399@srcf.ucam.org> <20060110001701.GA25690@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110001701.GA25690@vrfy.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 01:17:01AM +0100, Kay Sievers wrote:
> On Tue, Jan 10, 2006 at 12:07:58AM +0000, Matthew Garrett wrote:
> > Handwavy problem scenario - user A logs in, is given access to the 
> > soundcard. Starts running a program that when given appropriate signals 
> > will record from the system microphone. Logs out. Waits for user B, who 
> > he suspects is having an affair with his wife, and then monitors any 
> > conversations that user B has.
> 
> That can be solved in the user session handling and not in the kernel.

Without killing every application that they've been left running? How? 
The only way I can think of is by checking open files against a 
blacklist, which seems, uhm, fragile.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
