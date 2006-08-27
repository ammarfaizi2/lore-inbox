Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWH0B7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWH0B7i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 21:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWH0B7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 21:59:38 -0400
Received: from es1036.belits.com ([64.58.22.200]:2451 "EHLO es1036.belits.com")
	by vger.kernel.org with ESMTP id S1750886AbWH0B7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 21:59:38 -0400
Message-ID: <44F0FC5E.7040605@phobos.illtel.denver.co.us>
Date: Sat, 26 Aug 2006 19:58:54 -0600
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.17.11 -- compilation failure on alpha
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On alpha compilation fails because arch_mmap_check() is not defined -- 
mm/mmap.c does not include include/asm-generic/mman.h, the only place 
where it is defined as (0) for architectures that don't have it. The 
problem disappears if that definition is copied into mm/mmap.c itself 
or, better, include/asm-alpha/mman.h

-- 
Alex
