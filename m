Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbULVWmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbULVWmj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 17:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbULVWmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 17:42:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:63212 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261837AbULVWmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 17:42:36 -0500
Date: Wed, 22 Dec 2004 23:42:33 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Egmont Koblinger <egmont@uhulinux.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: wrong hardlink count for /proc/PID directories
In-Reply-To: <20041222221623.GA706@cs.bme.hu>
Message-ID: <Pine.LNX.4.61.0412222340540.475@yvahk01.tjqt.qr>
References: <20041222221623.GA706@cs.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>Tested on some 2.6.[7-9] kernels: a stat call for a /proc/SOMEPID
>directory returns a hard link count of 3, which is invalid, since these
>directories have three subdirectories (attr, fd and task) and hence the hard
>link counter should be 5.
>
>This causes at least 'find' (gnu findutils) to malfunction, it does not
>descend under /proc/SOMEPID/fd and /proc/SOMEPID/attr. See also:
>https://savannah.gnu.org/bugs/index.php?func=detailitem&item_id=11379

You could try working around this by using -noleaf. (Which is by no means a 
solution.)

Hm, I have 2.6.8+.9-rc2, and /proc/1 for example has a link count of 3 which 
seems reasonable: ".", "fd" and "task".


Jan Engelhardt
-- 
ENOSPC
