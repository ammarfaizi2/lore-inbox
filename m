Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274063AbRISNsz>; Wed, 19 Sep 2001 09:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274065AbRISNsg>; Wed, 19 Sep 2001 09:48:36 -0400
Received: from A76d9.pppool.de ([213.6.118.217]:39690 "HELO Nicole.muc.suse.de")
	by vger.kernel.org with SMTP id <S274063AbRISNsY>;
	Wed, 19 Sep 2001 09:48:24 -0400
Subject: Re: the Gimp and pre11
From: Daniel Egger <egger@suse.de>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010919034412.092EB9CF9@oscar.casa.dyndns.org>
In-Reply-To: <20010919034412.092EB9CF9@oscar.casa.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 19 Sep 2001 15:48:57 +0200
Message-Id: <1000907347.6897.8.camel@sonja>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mit, 2001-09-19 at 05:44, Ed Tomlinson wrote:

> I am editing 6 Megapixel files (2800x2048) and things like rotations seem to 
> have delays that were not happening with previous kernels.  My box has 320M.
> Seems that pre11 does not swap out as much as pre10 so Gimp has less to work
> with.

Since GIMP uses it's own memory management using a tile approach I
hardly doubt this is caused by swap usage if you defined the maximum
amount of memory GIMP should use correctly; though it may be that the
kernel swaps out tiles that the tilemanager considers to be active (and
thus in memory) this behaviour should not happen as long as the kernel
is not to eagerly swapping out memory and considering that the tiles
are referenced quite often it should not swap them to disc at all IF
the recently introduced algorithms work correctly.

Anyhow, just to make sure, would you please mention much memory you
assigned to GIMP and what else is running on the system?

--
Servus,
       Daniel

