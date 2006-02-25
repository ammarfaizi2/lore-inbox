Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWBYG7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWBYG7R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 01:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWBYG7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 01:59:16 -0500
Received: from ihug-mail.icp-qv1-irony4.iinet.net.au ([203.59.1.198]:36172
	"EHLO mail-ihug.icp-qv1-irony4.iinet.net.au") by vger.kernel.org
	with ESMTP id S932378AbWBYG7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 01:59:15 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,145,1139155200"; 
   d="scan'208"; a="626317469:sNHT385531682"
Message-ID: <44000036.7070403@eyal.emu.id.au>
Date: Sat, 25 Feb 2006 17:59:02 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Milan Kupcevic <milan@physics.harvard.edu>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au, torvalds@osdl.org
Subject: Re: [PATCH] sata_promise: Port enumeration order - SATA 150 TX4,
 SATA 300 TX4
References: <43FFAE3D.7010002@physics.harvard.edu>
In-Reply-To: <43FFAE3D.7010002@physics.harvard.edu>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milan Kupcevic wrote:
> From: Milan Kupcevic <milan@physics.harvard.edu>
> 
> Fix Promise SATAII 150 TX4 (PDC40518) and Promise SATA 300 TX4
> (PDC40718-GP) wrong port enumeration order that makes it (nearly)
> impossible to deal with boot problems using two or more drives.
> 
> Signed-off-by: Milan Kupcevic <milan@physics.harvard.edu>
> ---
> 
> The current kernel driver assumes:
> 
> port 1 - scsi3
> port 2 - scsi1
> port 3 - scsi0
> port 4 - scsi2

I totally agree with the fact that the Linux driver gets the ports wrong
when compared to the BIOS, Windows and surely contradicts the port
numbers printed on the board. I doubt we all got samples on the one
bad batch...

It *is* a real problem and if the solution is correct then I support it.

Maybe we need a quick feedback from current users: do you guys find
that the ports are detected as they are labelled (white silk screen)
on the board or do they show up out of order (as listed above by
Milan)?

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
