Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWAPLCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWAPLCd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 06:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWAPLCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 06:02:33 -0500
Received: from thorn.pobox.com ([208.210.124.75]:43415 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1750853AbWAPLCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 06:02:32 -0500
Date: Mon, 16 Jan 2006 04:02:28 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.15] screen remains blank after LID switch use
Message-Id: <20060116040228.13267e96.dickson@permanentmail.com>
In-Reply-To: <200601160946.51765.lkml@kcore.org>
References: <200601160946.51765.lkml@kcore.org>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006 09:46:51 +0100, Jan De Luyck wrote:

> I've recently gotten an Dell D610 laptop from my company. After some digging I 
> managed to get Linux running on it, with kernel 2.6.15 at this moment.
> 
> There is something odd going on with the LID switch functionality tho: 
> everytime the LID is closed, the screen goes off, as expected. Unfortunately, 
> the screen does not come back alive afterwards, it remains blank.
> 
> Starting X doesn't help, switching consoles doesn't help either. The problem 
> is appareant both in X and the console.
> 
> The laptop remains completely functional, except for the display.
> 
> Currently I'm not using a fb console, and the X driver is the i810.
> 
> Any ideas?

I hit this and manage to get myself out of it.

I run with many xterm windows open.  After opening the lid in my Inspiron 6000, I switched to a workspace with an open xterm window and type the equivalent of:
    xset dpms force suspend

(I usually use this command to blank the screen "right now".)

  $ more ~/bin/blank
  #! /bin/sh
  sleep 2
  xset dpms force suspend

Then when I move the mouse pointer or press a key, the screen turns back on.

	-Paul

