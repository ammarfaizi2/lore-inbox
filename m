Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTH3OQe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 10:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTH3OQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 10:16:34 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:28648 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261764AbTH3OQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 10:16:33 -0400
Date: Sat, 30 Aug 2003 10:13:59 -0400
From: Chris Heath <chris@heathens.co.nz>
To: Ralf.Hildebrandt@charite.de
Subject: Re:Re: Linux 2.6.0-test4
Cc: linux-kernel@vger.kernel.org
In-Reply-To: 20030830090411.GD27477@charite.de
Message-Id: <20030830095858.0895.CHRIS@heathens.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.06.02
X-Antirelay: Good relay from local net1 127.0.0.1/32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I still have issues with the keyboard -- sometimes when typing in the
> frambuffer console I get an "unknown scancode" and after that the CTRL
> key is stuck forever, which forces me to reboot.

Please post the full error message.  Does the error message always
contain the same scancode?

My guess is you can get out of that without a reboot.  Next time it
happens, try this:
   1. Press and release each Ctrl key. (This makes sure the key_down
      array is correct.)
   2. Switch to another console and back again. (This executes the
      compute_shiftstate function, which recalculates the shift
      state from the key_down array.)

Chris

