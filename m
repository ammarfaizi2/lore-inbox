Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUH3W0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUH3W0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUH3W0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:26:02 -0400
Received: from users.linvision.com ([62.58.92.114]:27018 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S264665AbUH3WZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 18:25:49 -0400
Date: Tue, 31 Aug 2004 00:25:45 +0200
From: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Driver retries disk errors.
Message-ID: <20040830222545.GB31968@bitwizard.nl>
References: <20040830163931.GA4295@bitwizard.nl> <20040830174632.GA21419@thunk.org> <41337153.60505@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41337153.60505@superbug.demon.co.uk>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 07:26:27PM +0100, James Courtier-Dutton wrote:
> It does the same retries with CD-ROM and DVDs, and if the retries fail, 
> it disables DMA!

As a matter of fact, we've had a computer where I tried to
get an MFM drive working. There I had changed lots of settings
in the BIOS to disable the onboard IDE and stuff like that. 
When we tried to get IDE back working, we encountered the 
situation where the secondary channel would not DMA unless
<something in the BIOS>. There the strategy "disable DMA"
works: the drive is "switched down" and something works. 

I remember from the old days that this was: "To enable
the user to continue to use the system to fix the problem". 

However, in practise, this failure is not something that
you can fix "if you have access to your drive", but something
you get to fix in the BIOS. So does this still help? 

Well, maybe PIO is so "basic" that it will always work, 
and is a good "last resort'.

The "same retries with CDROM" stems from the fact that the
code was initially duplicated. (as in cp ide-disk.c ide-cd.c) 
The fact that DVDs are nowadays writable should be a hint that 
the drivers may be better off getting merged one of these days. 

	Roger. 

-- 
+-- Rogier Wolff -- www.harddisk-recovery.nl -- 0800 220 20 20 --
| Files foetsie, bestanden kwijt, alle data weg?!
| Blijf kalm en neem contact op met Harddisk-recovery.nl!
