Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUARW7K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 17:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbUARW7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 17:59:09 -0500
Received: from server1.fast24.net ([217.10.137.141]:64482 "HELO
	server1.fast24.net") by vger.kernel.org with SMTP id S264256AbUARW7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 17:59:07 -0500
Message-ID: <400B0FC7.9050206@sms.ed.ac.uk>
Date: Sun, 18 Jan 2004 22:59:19 +0000
From: Michael Lothian <s0095670@sms.ed.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Asus A7V600 (KT600) and Radeon 9600XT using Kernel 2.6.1 with XFree86
 4.4 Celebration!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've finally got it to work!

I followed the advice from http://kerneltrap.org/node/view/1685 in
removing the _ke_amd_adv_spec_cache_feature though I'm not sure this was
necessarry

I removed the highmem patch from the make.sh (Also not sure if this is
100% necessary)

I then popped the following lines in my modules.conf:

alias   char-major-226-0 fglrx
alias   char-major-10-175 agpgart
above agpgart via-agp
above fglrx agpgart

and generated a new modprobe.conf file.

You can then setup the graphics card using fglrxsetup

Any way I'm not putting the flags out :D

Mike

