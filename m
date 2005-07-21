Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVGUUJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVGUUJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 16:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVGUUJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 16:09:29 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:43109 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261871AbVGUUIH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 16:08:07 -0400
Date: Thu, 21 Jul 2005 21:47:18 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add -Wun-def to global CFLAGS
Message-ID: <20050721214718.GB12414@mars.ravnborg.org>
References: <20050721190209.GA13633@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050721190209.GA13633@suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 09:02:09PM +0200, Olaf Hering wrote:
> 
> A recent change to the aic scsi driver removed two defines to detect 
> endianness. cpp handles undefined strings as 0. As a result, the test turned
> into #if 0 == 0 and the wrong code was selected.
> Adding -Wundef to global CFLAGS will catch such errors.

To my suprise it did not spew out a lot of warnings in my build.
In the kernel we quite consitently use Â#ifdef - good!
Applied.

	Sam
