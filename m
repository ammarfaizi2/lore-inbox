Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266916AbUHDAtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266916AbUHDAtp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 20:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUHDAtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 20:49:45 -0400
Received: from zero.aec.at ([193.170.194.10]:6404 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266916AbUHDAti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 20:49:38 -0400
To: L A Walsh <lkml@tlinx.org>
cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com, nathans@sgi.com
Subject: Re: XFS: how to NOT null files on fsck?
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx>
	<40EEC9DC.8080501@tlinx.org> <20040729013049.GE800@frodo>
	<410FDA19.9020805@tlinx.org>
From: Andi Kleen <ak@muc.de>
Date: Wed, 04 Aug 2004 02:48:09 +0200
In-Reply-To: <410FDA19.9020805@tlinx.org> (L. A. Walsh's message of "Tue, 03
 Aug 2004 11:31:53 -0700")
Message-ID: <m3d627bueu.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

L A Walsh <lkml@tlinx.org> writes:

> Now I know it takes a while before data may end up on disk and that it
> may not go out to disk in an ordered fashion, but 2-3 days?  This isn't
> a case of a multi-extent file.  My current fstab is only 1335 bytes long.
> I doubt it has ever been more than 2.

Is this perhaps on a laptop? Some scripts for laptop use configure
insanely long data flush times to conserve HD spin time. Sometimes
it is even completely turned off (laptop mode). The extent 
flush is dependent on the configured bdflush or pdflushd data
timeouts.

The truncate is independent from this because it is flushed with a 
different path.

-Andi


