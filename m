Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVCXWbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVCXWbQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 17:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVCXWbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 17:31:16 -0500
Received: from mail.suse.de ([195.135.220.2]:48054 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261181AbVCXWbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 17:31:14 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>
	<Pine.LNX.4.62.0503221656310.2683@dragon.hyggekrogen.localhost>
	<200503231740.09572.maillist@zuco.org>
	<Pine.LNX.4.61.0503231829570.1481@yvahk01.tjqt.qr>
	<20050323174925.GA3272@zero>
	<Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be>
	<20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com>
	<Pine.LNX.4.61.0503242047000.8883@yvahk01.tjqt.qr>
From: Andreas Schwab <schwab@suse.de>
X-Yow: By MEER biz doo SCHOIN..
Date: Thu, 24 Mar 2005 23:31:12 +0100
In-Reply-To: <Pine.LNX.4.61.0503242047000.8883@yvahk01.tjqt.qr> (Jan
 Engelhardt's message of "Thu, 24 Mar 2005 20:47:47 +0100 (MET)")
Message-ID: <jeu0n0ptfz.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>> > There's probably a number of apps that skip the first two dirents, instead
>>> > of checking for the dot dirs.
>>> Yep, check `-noleaf' in find(1)
>>Then it is broken in several ways.  
>>First, file systems are not required to implement ".." (only "." is
>>magical, ".." is a courtesy).  
>
> Heh, what would happen if .. disappeared?

"." and ".." are handled in the VFS.  No filesystem code ever sees them
during lookup.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
