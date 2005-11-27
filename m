Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVK0BXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVK0BXt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 20:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVK0BXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 20:23:49 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:18313 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750804AbVK0BXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 20:23:48 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: capturing oopses
To: vherva@vianova.fi, Adrian Bunk <bunk@stusta.de>,
       Folkert van Heusden <folkert@vanheusden.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 27 Nov 2005 02:10:59 +0100
References: <5bG4q-8ks-17@gated-at.bofh.it> <5daDm-1Cg-15@gated-at.bofh.it> <5de3Z-6CJ-13@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EgB4G-00013Z-9E@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva <vherva@vianova.fi> wrote:

> Speaking of which, does anybody know a feasible (as in "not too much harder
> than manually typing it in manually") way to OCR characters from vga text
> mode screen captures - or even digican shots?
> 
> The vga text mode captures are from a remote administration interface (such
> as HP RILOE or vmware gsx console) so they are pixel perfect and OCR should
> be doable.

If it's a 640 pixel width image and you've got the right font loaded, the
VGA function 0x08 will get you the character at the current cursor position.
It's also used by PRTSCR, so pressing it in a DOS viewer may dump the text
to LPT1. If you redirected it to a serial console, you might also catch it.
(I never tried).
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
