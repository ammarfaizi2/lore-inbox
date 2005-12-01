Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVLAL5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVLAL5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 06:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVLAL5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 06:57:23 -0500
Received: from networks.syneticon.net ([213.239.212.131]:63936 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP id S932169AbVLAL5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 06:57:22 -0500
Message-ID: <438EE515.1080001@wpkg.org>
Date: Thu, 01 Dec 2005 12:57:09 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mozilla Thunderbird 1.0.7-3mdk (X11/20051015)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: loadavg always equal or above 1.00 - how to explain?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed one of my Samba + OpenLDAP servers, running 2.6.11.4 kernel 
has loadavg always equal or above 1.00, although I can't explain it.

# cat /proc/loadavg
1.00 1.10 1.06 1/65 782

This server is barely used, and as I remember, loadavg was always close 
to 0.00 on that system.

When I view the process list with top, no process takes more than 1% of 
CPU time; RAM usage is also minimal:


# free
              total       used       free     shared    buffers     cached
Mem:        320836     241016      79820          0      23308     177232
-/+ buffers/cache:      40476     280360
Swap:       811272      14612     796660

This has ~ 50 processes running (ps aux|wc -l), and ~ 50 network 
connections (netstat -tupna|wc -l), so everything normal.

Nothing unusual in dmesg, too.

What can cause this anormal load, and how can I spot it?


-- 
Tomek
http://wpkg.org
WPKG - software deployment and upgrades with Samba
