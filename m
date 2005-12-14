Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbVLNT6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbVLNT6u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbVLNT6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:58:50 -0500
Received: from ns.suse.de ([195.135.220.2]:2694 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964916AbVLNT6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:58:49 -0500
Date: Wed, 14 Dec 2005 20:58:48 +0100
From: Andi Kleen <ak@suse.de>
To: Dave <dave.jiang@gmail.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: x86_64 segfault error codes
Message-ID: <20051214195848.GQ23384@wotan.suse.de>
References: <8746466a0512141017j141d61dft3dd2b1ab95dc2351@mail.gmail.com> <p73hd9b8r9w.fsf@verdi.suse.de> <8746466a0512141124u68c3f5c9o3411c8af64667d8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8746466a0512141124u68c3f5c9o3411c8af64667d8d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 12:24:42PM -0700, Dave wrote:
> Ah ok, thx! Looks like the comment in mm/fault.c is wrong then.... It
> says bit 3 is instruction fetch and no mention of bit 4.

Don't know what kernel you're looking at, but 2.6.15rc5 has

 *      bit 0 == 0 means no page found, 1 means protection fault
 *      bit 1 == 0 means read, 1 means write
 *      bit 2 == 0 means kernel, 1 means user-mode
 *      bit 3 == 1 means use of reserved bit detected
 *      bit 4 == 1 means fault was an instruction fetch



-Andi
