Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUEWIy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUEWIy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 04:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUEWIy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 04:54:58 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:2821 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262389AbUEWIy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 04:54:57 -0400
Date: Sun, 23 May 2004 10:55:57 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-mm3: i810 agpgart module can't be initialized
Message-Id: <20040523105557.115b91a0.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clemens,

> I have the same problem with 2.6.6-mm3 like I had with 2.6.6-mm2
> 
> in my dmesg I have this (complete attached):
> 
> i810fb: cannot acquire agp
> ...
> Linux agpgart interface v0.100 (c) Dave Jones
> [drm:i810_probe] *ERROR* Cannot initialize the agpgart module
> ...

Could be that you have the i2c-i810 driver loaded. Both drivers (i2c and
fb) request the PCI device AFAIK, so they are mutually exclusive.

Both drivers should proably be merged so as to solve that issue, but
nodoby seems to be interested in working on this right now. And I won't
do it, I don't even have compatible hardware to test on.

Just my two cents, hope it helps.

-- 
Jean Delvare
http://khali.linux-fr.org/
