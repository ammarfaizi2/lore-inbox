Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317662AbSHHR2N>; Thu, 8 Aug 2002 13:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317674AbSHHR2N>; Thu, 8 Aug 2002 13:28:13 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:47886 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317662AbSHHR2N>; Thu, 8 Aug 2002 13:28:13 -0400
Date: Thu, 8 Aug 2002 14:31:40 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>,
       <jmacd@namesys.com>, <phillips@arcor.de>, <rml@tech9.net>
Subject: Re: [PATCH] lock assertion macros for 2.5.30
In-Reply-To: <20020808170824.GA29468@sgi.com>
Message-ID: <Pine.LNX.4.44L.0208081430310.2589-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Jesse Barnes wrote:
> On Thu, Aug 08, 2002 at 08:00:45AM +0200, Jens Axboe wrote:

> > For MUST_NOT_HOLD to work, you need to take into account which processor
> > took the lock etc.

[snip]

> Agreed.  I'll post another patch that doesn't mess with the scsi
> stuff.  Maybe later I can put together a useful
> 'lock-not-held-on-this-cpu' macro.

You don't need to put this in a macro.  This test is valid
for ALL spinlocks in the kernel and can be done from inside
the spin_lock() macro itself, when spinlock debugging is on.

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

