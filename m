Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUHMRH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUHMRH2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbUHMRH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:07:28 -0400
Received: from monet.celtelplus.com ([217.113.64.7]:20921 "EHLO
	monet.celtelplus.com") by vger.kernel.org with ESMTP
	id S266233AbUHMRGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:06:21 -0400
Message-ID: <411CF503.40202@celtelplus.com>
Date: Fri, 13 Aug 2004 19:06:11 +0200
From: Anand Buddhdev <anand@celtelplus.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: binfmt_misc trouble with kernel 2.6.7
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few days ago I upgraded to fedora kernel 2.6.7-1.494.2.2. Before that, 
I had kernels in which binfmt_misc was compiled as a module. The wine 
init script modprobe'd the module and then registered /usr/bin/wine as a 
handler for windows executables. However, in the new 2.6.7 kernel, 
binfmt_misc is compiled into the kernel, so the modprobe in the wine 
init script fails. I can fix that, but main problem I am having is that 
now, the permissions on the /proc/sys/fs/binfmt_misc directory are 0555:

dr-xr-xr-x  2 root root 0 Aug 13 19:04 /proc/sys/fs/binfmt_misc

I cannot create a file called register under /proc/sys/fs/binfmt_misc.

I created a Fedora bugzilla entry for this but I was told that this is a 
problem in the kernel upstream. Is this indeed a known problem, and is 
there a fix?
