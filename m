Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbUJWTBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbUJWTBz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 15:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUJWTBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 15:01:55 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:57502 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261277AbUJWTBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 15:01:50 -0400
Date: Sat, 23 Oct 2004 21:06:19 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: linux-kernel@vger.kernel.org, geert@linux-m68k.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <Pine.LNX.4.58.0410232104510.3984@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> On Wed, 20 Oct 2004, Jon Smirl wrote:

>> If you implement VGA you will be able to boot and work in any x86
>> system without writing any code other than the BIOS.
> 
> Ugh... I prefer _not_ to have VGA compatibility.

If you want to be able to see the BIOS, you'll need some legacy emulation,
but it should be enough to implement MDA output.

Since some VGA cards used to depend on the MDA/CGA BIOS routines, most
(all?) BIOS variants will implement all nescensary IO functions. You'll
need some MDA registers for the cursor position (that don't even clash with
EGA/VGA/CGA), 4K mapped memory at B000:0000 and a loop translating the text.
-- 
Top 100 things you don't want the sysadmin to say:
21. where did you say those backup tapes were kept?
