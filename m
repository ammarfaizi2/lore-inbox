Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934996AbWK3Kah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934996AbWK3Kah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934994AbWK3Kag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:30:36 -0500
Received: from mail.suse.de ([195.135.220.2]:26578 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S934264AbWK3Kaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:30:35 -0500
From: Andreas Schwab <schwab@suse.de>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 1/3] mm: pagecache write deadlocks zerolength fix
References: <20061130072058.GA18004@wotan.suse.de>
	<jeodqptf3o.fsf@sykes.suse.de> <20061130101933.GA12579@wotan.suse.de>
X-Yow: I brought my BOWLING BALL - and some DRUGS!!
Date: Thu, 30 Nov 2006 11:30:33 +0100
In-Reply-To: <20061130101933.GA12579@wotan.suse.de> (Nick Piggin's message of
	"Thu, 30 Nov 2006 11:19:34 +0100")
Message-ID: <jeac29teeu.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> writes:

> On Thu, Nov 30, 2006 at 11:15:39AM +0100, Andreas Schwab wrote:
>> Nick Piggin <npiggin@suse.de> writes:
>> 
>> > writev with a zero-length segment is a noop, and we shouldn't return EFAULT.
>> 
>> AFAICS the callers of these functions never pass a zero length.
>
> They can in the case of a zero length write.

How?  All (indirect) callers I could find explicitly handle the
zero-length case.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
