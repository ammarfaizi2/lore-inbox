Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbULVXTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbULVXTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 18:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbULVXTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 18:19:31 -0500
Received: from sziami.cs.bme.hu ([152.66.242.225]:26585 "EHLO sziami.cs.bme.hu")
	by vger.kernel.org with ESMTP id S262080AbULVXT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 18:19:28 -0500
Date: Thu, 23 Dec 2004 00:02:37 +0100
From: Egmont Koblinger <egmont@uhulinux.hu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: wrong hardlink count for /proc/PID directories
Message-ID: <20041222230237.GA2175@cs.bme.hu>
References: <20041222221623.GA706@cs.bme.hu> <Pine.LNX.4.61.0412222340540.475@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412222340540.475@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 11:42:33PM +0100, Jan Engelhardt wrote:

> Hm, I have 2.6.8+.9-rc2, and /proc/1 for example has a link count of 3 which 
> seems reasonable: ".", "fd" and "task".

No, it'd have to be 4 in this case: "1" from "/proc", "." from "/proc/1",
".." from "/proc/1/fd" and ".." from "/proc/1/task" all point to "/proc/1".
It should always be the number of real subdirectories plus two.

Just copy this directory recursively to a real filesystem and check the
hardlink count there.



-- 
Egmont
