Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTFFSoS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 14:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTFFSoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 14:44:18 -0400
Received: from dp.samba.org ([66.70.73.150]:17895 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262179AbTFFSoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 14:44:17 -0400
Date: Sat, 7 Jun 2003 04:41:32 +1000
From: Anton Blanchard <anton@samba.org>
To: linas@austin.ibm.com
Cc: lnz@dandelion.com, mike@i-connect.net, eric@andante.org,
       linux-kernel@vger.kernel.org, olh@suse.de, groudier@free.fr,
       axboe@suse.de, acme@conectiva.com.br, linas@linas.org
Subject: Re: Patches for SCSI timeout bug
Message-ID: <20030606184132.GC6069@krispykreme>
References: <20030604163415.A41236@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030604163415.A41236@forte.austin.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> 2) By incresing the sym53c8xx post-reset delay to at least
>    12 seconds.
> 
> Fix 2) may not be bad: I have at least one scsi hard drive which 
> takes 5 seconds to recover from a bus reset.   On the other hand,
> fix 2) makes the boot process longer: it introduces a delay of 
> N x 12 seconds, where N is the number of scsi channels.
> (Most cards have two channels; some server-class machines with 
> many cards may have a significantly longer boot).

Yep, Ive got a box with 42 scsi controllers and the time to probe SCSI
is already unbearable :) 

So I like fix 1 as well.

Anton
