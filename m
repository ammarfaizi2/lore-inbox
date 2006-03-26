Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWCZLZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWCZLZN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 06:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWCZLZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 06:25:13 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:46806 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750835AbWCZLZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 06:25:11 -0500
Date: Sun, 26 Mar 2006 13:24:57 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Stas Sergeev <stsp@aknet.ru>
cc: 7eggert@gmx.de, dtor_core@ameritech.net,
       Linux kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
In-Reply-To: <44266472.5080309@aknet.ru>
Message-ID: <Pine.LNX.4.58.0603261318170.3990@be1.lrz>
References: <5TCqf-E6-49@gated-at.bofh.it> <5TCqf-E6-51@gated-at.bofh.it>
 <5TCqf-E6-53@gated-at.bofh.it> <5TCqg-E6-55@gated-at.bofh.it>
 <5TCqf-E6-47@gated-at.bofh.it> <E1FMv1A-0000fN-Lp@be1.lrz> <44266472.5080309@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2006, Stas Sergeev wrote:
> Bodo Eggert wrote:

> >> The problem is that the snd-pcsp doesn't replace pcspkr.
> > If that's the problem, create a minimal input driver that will signal the
> > snd-pcsp to beep, and change the original pcspkr to include "(Non-ALSA)".

> Yes, making snd-pcsp to produce the console beeps and
> making it mutually exclusive with pcspkr is possible.
> But I think it is undesireable. People that don't like
> the console beeps (myself included) simply do not load
> the pcspkr module right now. If snd-pcsp is to produce
> the beeps, then not loading pcspkr will not get the desired
> effect any more, and the only possibility would be to,
> probably, add the separate mixer control for the beeps.

I asumed the input driver would be an extra module. Otherwise it should at 
least be a runtime option (off cause).
-- 
Microwave: Signal from a friendly micro... 
