Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267428AbUGNQYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267428AbUGNQYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267436AbUGNQYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:24:30 -0400
Received: from gate.in-addr.de ([212.8.193.158]:31905 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S267428AbUGNQY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:24:27 -0400
Date: Wed, 14 Jul 2004 18:23:57 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Christian Borntraeger <linux-kernel@borntraeger.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] removal of sync in panic
Message-ID: <20040714162357.GU3922@marowsky-bree.de>
References: <200407141745.47107.linux-kernel@borntraeger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200407141745.47107.linux-kernel@borntraeger.net>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-07-14T17:45:46,
   Christian Borntraeger <linux-kernel@borntraeger.net> said:

> I can imagine several changes but I am not sure if this is a problem which 
> must be fixed and which fix is the best.
> Here are my alternatives:
> 
> 1. remove sys_sync completely: syslogd and klogd use fsync. No need to help 
> them. Furthermore we have a severe problem which is worth a panic, so we 
> better dont do any I/O.

I've seen exactly the behaviour you describe and would be inclined to go
for this option too.

> 3. Add an 
>         if (doing_io())
>                 printk(KERN_EMERG "In I/O routine - not syncing\n");
> check like in_interrupt check. Unfortunately I have no clue how this can be 
> achieved and it looks quite ugly.

This would also work of course, but as you point out, it's more complex.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

