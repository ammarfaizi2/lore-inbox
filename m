Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVCBFhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVCBFhV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 00:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVCBFhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 00:37:21 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:33558 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262187AbVCBFhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 00:37:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=N21qe3bA0hoBQqR10BoG+jFRNdeIGgh+I8jGquTwMmrW6VB8A1QRUM6iCZ+XiSLiV8VVvMClE4m1DvTiqL7103poHuv5df/YqnBTkdC+TaNq9HFG2CNPqK9fQtgnof+MKXg/mWhzwg8QOdeJUNSgq11L1rrHUmTpRlk2KzC/iRQ=
Message-ID: <422550FC.9090906@gmail.com>
Date: Wed, 02 Mar 2005 00:37:00 -0500
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Undefined symbols in 2.6.11-rc5-mm1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody, I just joined the LKML!

Don't worry, this is not just a test message, I do actually have 
something to say. I just compiled 2.6.11-rc5-mm1 and got undefined 
symbols "match_int", "match_octal", "match_token", and "match_strdup" in 
several modules. This is using binutils 2.15 and gcc 3.4.4 from Debian.
I grepped around and found those functions in lib/parser.c, so I just 
looked at the output of "make V=1" and invoked "ld" manually, adding in 
lib/lib.a, and the modules work fine now. However, I don't know enough 
about the kernel build process to make a patch to fix this, so I'm just 
notifying people of the problem.

BTW, I just got a new hard disk and put Reiser4 on it. It works great! 
Keep up the good work guys!
