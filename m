Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbUKVXyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUKVXyK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbUKVXvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:51:52 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:52215
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S262464AbUKVXsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:48:43 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problem
Date: Mon, 22 Nov 2004 23:48:42 +0000
User-Agent: KMail/1.7.1
Cc: Jens Axboe <axboe@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk> <20041122130202.GO10463@suse.de> <200411221919.32174.alan@chandlerfamily.org.uk>
In-Reply-To: <200411221919.32174.alan@chandlerfamily.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411222348.42149.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 November 2004 19:19, Alan Chandler wrote:
> On Monday 22 November 2004 13:02, Jens Axboe wrote:
> > I think the more correct patch is the following. It seems I was wrong in
> > assuming that the ide_intr() path already waited 400ns for us, I think
> > this should work for you. Can you test it?
>
> Bad news - it didn't work.
>
> It certainly looks as though it should - I am trying to find out what not.
>

I meant of course "I am trying to find out why not".

If I make the delay 600ns it works - I guess my hardware is a little off spec.

If I leave the original udelay(1) in there, I get irq timeouts all over the 
place.



-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
