Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVLARoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVLARoL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVLARoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:44:11 -0500
Received: from cantor.suse.de ([195.135.220.2]:7055 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932361AbVLARoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:44:10 -0500
From: Andreas Schwab <schwab@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: discrepency between "df" and "du" on tmpfs filesystem?
References: <438F179E.5040402@nortel.com>
	<Pine.LNX.4.61.0512011634370.26131@goblin.wat.veritas.com>
X-Yow: The fact that 47 PEOPLE are yelling and sweat is cascading
 down my SPINAL COLUMN is fairly enjoyable!!
Date: Thu, 01 Dec 2005 18:44:00 +0100
In-Reply-To: <Pine.LNX.4.61.0512011634370.26131@goblin.wat.veritas.com> (Hugh
	Dickins's message of "Thu, 1 Dec 2005 16:41:15 +0000 (GMT)")
Message-ID: <je4q5s67bz.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> writes:

> On Thu, 1 Dec 2005, Christopher Friesen wrote:
>> 
>> Someone noticed this on one of our machines.  The rootfs is a 256MB tmpfs
>> filesystem.  Depending on how you check the size, you get two different
>> answers.
>> 
>> root@10.41.50.66:/root> df -kl
>> rootfs                  262144    255684      6460  98% /
>> 
>> root@10.41.50.66:/root> du -sxk /
>> 204672  /
>> 
>> Anyone know what's going on?
>
> df tells you what the filesystem says is in use or free, via statfs.
> du goes looking at the contents of the filesystem, totalling stats.
> Any files unlinked but held open will be counted by df but not by du.
> There might also be a discrepancy over indirect blocks, I'm not sure.

Also an empty filesystem usually does not have zero use, since the
filesystem overhead (inode table, etc) may be accounted in the statfs
counts.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
