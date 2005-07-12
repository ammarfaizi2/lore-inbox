Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVGLVs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVGLVs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVGLVs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:48:57 -0400
Received: from [203.171.93.254] ([203.171.93.254]:19600 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262472AbVGLVqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:46:30 -0400
Subject: Re: [patch] suspend: update documentation
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: randy_dunlap <rdunlap@xenotime.net>
Cc: Pavel Machek <pavel@ucw.cz>, akpm@zip.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050712102407.0fce8b7c.rdunlap@xenotime.net>
References: <20050712090510.GG1854@elf.ucw.cz>
	 <20050712102407.0fce8b7c.rdunlap@xenotime.net>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121204890.13869.175.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 13 Jul 2005 07:48:10 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-13 at 03:24, randy_dunlap wrote:
> On Tue, 12 Jul 2005 11:05:10 +0200 Pavel Machek wrote:
> 
> | Update suspend documentation.
> | 
> | Signed-off-by: Pavel Machek <pavel@suse.cz>
> | 
> | ---
> | 
> | diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
> | --- a/Documentation/power/swsusp.txt
> | +++ b/Documentation/power/swsusp.txt
> | @@ -318,3 +318,10 @@ As a rule of thumb use encrypted swap to
> |  system is shut down or suspended. Additionally use the encrypted
> |  suspend image to prevent sensitive data from being stolen after
> |  resume.
> | +
> | +Q: Why we cannot suspend to a swap file?
> 
> Q: Why can't we suspend to a swap file?
> or
> Q: Why can we not suspend to a swap file?
> 
> | +
> | +A: Because accessing swap file needs the filesystem mounted, and
> | +filesystem might do something wrong (like replaying the journal)
> | +during mount. [Probably could be solved by modifying every filesystem
> | +to support some kind of "really read-only!" option. Patches welcome.]

This is wrong. Suspend2 has supported writing to a swap file for a long
time (since 1.0), without requiring the filesystem to be mounted when
resuming. We just need to store the bdev and block numbers in the image
header.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

