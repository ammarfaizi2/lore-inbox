Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263063AbUJ1NTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbUJ1NTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 09:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbUJ1NTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 09:19:04 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:31247 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263057AbUJ1NSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 09:18:47 -0400
To: Nigel Kukard <nkukard@lbsd.net>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9bk6 msdos fs OOPS
References: <41809921.10200@lbsd.net>
	<200410281055.47263.vda@port.imtp.ilyichevsk.odessa.ua>
	<4180A9A4.4000503@lbsd.net> <873bzzw60c.fsf@devron.myhome.or.jp>
	<4180CF03.3090207@lbsd.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 28 Oct 2004 22:18:08 +0900
In-Reply-To: <4180CF03.3090207@lbsd.net> (Nigel Kukard's message of "Thu, 28
 Oct 2004 10:50:43 +0000")
Message-ID: <87sm7zgewf.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Kukard <nkukard@lbsd.net> writes:

> fat_cache_check: tsc 239046359353, comm eog, pid 4293, id 0, contig 0,
> fclus 1, dclus 274
> tsc 239046276777, comm eog, pid 4294, id 1, contig 2, fclus 1, dclus 274

This file was accessed by multiple process surely. This state is valid.
The wrong is BUG_ON(). I'll remove it.

Thank you for helping debug.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
