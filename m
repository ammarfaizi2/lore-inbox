Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVHCGTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVHCGTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVHCGS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:18:59 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:43216 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262093AbVHCGSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:18:53 -0400
Date: Wed, 3 Aug 2005 08:18:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Johan Veenhuizen <veenhuizen@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12.3] Deny chmod in /proc/<pid>/
In-Reply-To: <42efd43d.ijkrXtpGJUM7deW2%veenhuizen@users.sf.net>
Message-ID: <Pine.LNX.4.61.0508030816150.2263@yvahk01.tjqt.qr>
References: <42efd43d.ijkrXtpGJUM7deW2%veenhuizen@users.sf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This patch tries to fix the strange behaviour in /proc/<pid>/,
>where it is currently possible for the owner of a process to
>temporarily chmod the entries.

I am on 2.6.13-rc3-git5 and I do not see such behavior:

08:16 spectre:/proc/21345 # chown 1337 smaps
08:16 spectre:/proc/21345 # l -n smaps
-r--r--r--  1 25121 0   0 Aug  3 08:16 smaps
08:16 spectre:/proc/21345 #

>The patch does also trigger an EPERM when someone tries
>to chown/chgrp an entry (which is currently silently ignored).

That's true. Though, chmod /proc/21345 correctly yielded EPERM.

>Please send comments, corrections and suggestions.




Jan Engelhardt
-- 
