Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUJ1QEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUJ1QEO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbUJ1QEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:04:12 -0400
Received: from main.gmane.org ([80.91.229.2]:48824 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261964AbUJ1P4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:56:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: massive cross-builds without too much PITA
Date: Fri, 29 Oct 2004 00:56:32 +0900
Message-ID: <clr4ri$p27$1@sea.gmane.org>
References: <20041028054833.GP24336@parcelfarce.linux.theplanet.co.uk> <Pine.GSO.4.61.0410281331320.7058@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041016
X-Accept-Language: bg, en, ja, ru, de
In-Reply-To: <Pine.GSO.4.61.0410281331320.7058@waterleaf.sonytel.be>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Have you considered http://distcc.samba.org/ ??
I use it to compile my (almost stock) kernels and it scales perfectly (5 boxen now).

I have a dirty shell script to:
	ssh host13.mydomain.org "cat /proc/config.gz" |gunzip >//var/tmp/kernels/linux-2.6.8-KK1_host13/.config
	cd linux-2.6.8-KK1 && make old_config && make menuconfig && make
	put the output in /var/tmp/kernels/linux-2.6.8-KK1_host13 (KBOULD_OUT),
	rsync with the host (/usr/src/linux-2.6.8-KK1 and /var/tmp/kernels/linux-2.6.8-KK1_host13),
	ssh ot host13 and "cd /usr/src/linux-2.6.8-KK1; make modules_install",
	cp kernel to /boot, change /boot/bzImage to point to it

Using distcc as I said, I compile for about ten hosts this way keeping the same tree, but with different config.

Kalin.
	
P.S. If anybody is interested in the exact script,  contact me by e-mail. Too dirty code to be presented here :-)

-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

