Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbTFTJQh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 05:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTFTJQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 05:16:37 -0400
Received: from ns.suse.de ([213.95.15.193]:2822 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262530AbTFTJQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 05:16:36 -0400
To: Fruhwirth Clemens <clemens-dated-1056963973.bf26@endorphin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initial Vector Fix for loop.c.
References: <20030620090612.GA1322@ghanima.endorphin.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Jun 2003 11:30:03 +0200
In-Reply-To: <20030620090612.GA1322@ghanima.endorphin.org.suse.lists.linux.kernel>
Message-ID: <p73u1al3xlw.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens <clemens-dated-1056963973.bf26@endorphin.org> writes:

> So go for it. Fix it before 2.6.x is out and we're stuck with this crap
> again. 

This will break existing crypto loop installations, making
the existing encrypted image unreadable. After all this is Linux
here, not HackOS where you can break user file system formats at will.
The only way to implement this is with a new flag that is set by losetup
and keep the old behaviour by default.

-Andi
