Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbUKWHO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbUKWHO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 02:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUKWHOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 02:14:01 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:29169
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S262284AbUKWHNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 02:13:33 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd problem
Date: Tue, 23 Nov 2004 07:13:31 +0000
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200411201842.15091.alan@chandlerfamily.org.uk> <200411221919.32174.alan@chandlerfamily.org.uk> <200411222348.42149.alan@chandlerfamily.org.uk>
In-Reply-To: <200411222348.42149.alan@chandlerfamily.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411230713.32013.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 November 2004 23:48, Alan Chandler wrote:
...
> If I make the delay 600ns it works - I guess my hardware is a little off
> spec.
>

I did a binary chop on the value to find the cut off point between what works 
and what doesn't.  Its approx 535ns (534 failed, 537 worked).

All this was with 2.6.9, 

2.6.10-rc2 is still failing during the cd initialisation on boot.  Here I 
tried with bot 600ns and 700ns delays in drive_is_ready, but both values fail 
with what looks like missed interrupts.  I'll try instrumenting this a bit 
more to find out what is happening.

-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
