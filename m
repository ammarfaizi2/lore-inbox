Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVDKK0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVDKK0X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 06:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVDKK0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 06:26:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18356 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261767AbVDKK0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 06:26:09 -0400
Date: Mon, 11 Apr 2005 12:25:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050411102550.GD1353@elf.ucw.cz>
References: <4259B474.4040407@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4259B474.4040407@domdv.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch adds the core functionality for the encrypted
> suspend image.

[Please inline patches, it makes it easier to comment on them.]

You seem to reuse same key/iv for all the blocks. I'm no crypto
expert, but I think that is seriously wrong... You probably should use
block number as a IV or something like that.

Does it slow down swsusp in measurable way, or is it just lost in the
noise?
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
