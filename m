Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVK0BED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVK0BED (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 20:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVK0BEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 20:04:01 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:55693 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750803AbVK0BEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 20:04:00 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: Paused I/O versus regular I/O
To: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Sun, 27 Nov 2005 01:52:49 +0100
References: <5dato-1qR-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EgAmg-00012X-4S@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> wrote:

> Could anyone tell me what the difference is between "paused" I/O
> (inb_p, oub_p and friends) and regular I/O (inb, oub and friends)? I
> understand that the former includes some delays here and there, but how
> do I know when to use the paused variant, and when the non-paused
> variant is OK?

AFAIK, some old hardware needs it. The original ISA bus speed was 4.77 MHz,
and AT changed it to 8 MHz. Some chips needed extra delays to compensate,
and those chips stayed around for a long time.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
