Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbULZPw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbULZPw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 10:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbULZPw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 10:52:57 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:14260 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261678AbULZPuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 10:50:19 -0500
Subject: Re: Ho ho ho - Linux v2.6.10
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Blazejowski <diffie@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Diffie <diffie@blazebox.homeip.net>
In-Reply-To: <Pine.LNX.4.58.0412252121370.2353@ppc970.osdl.org>
References: <9dda349204122520106f3b2f46@mail.gmail.com>
	 <Pine.LNX.4.58.0412252121370.2353@ppc970.osdl.org>
Content-Type: text/plain
Date: Sun, 26 Dec 2004 09:46:51 -0600
Message-Id: <1104076011.5268.20.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-25 at 21:27 -0800, Linus Torvalds wrote:
> As to what the "DV failed", it's apparently normal if DV is disabled, 
> whatever the hell that is.  James will know whether it's something to 
> worry about..

DV is Domain Validation.  It's a way of probing the SCSI bus to see what
type of transfer speeds and widths it can support.  DV is part of the
mid-layer SPI transport class, which is where most drivers get it from.
However, this message is from the aic7xxx which does its own DV
separately from the mid-layer.  As far as I can tell from the aic7xxx
code, it has a state machine model of DV and it prints this message if
it goes through an unexpected transition of that state machine, but I've
no idea from the message what actually happened.  Everything seems to
proceed normally, since the device that caused the problems is later
configured at 160MB/s (the maximum the aic7xxx can do).

James


