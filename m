Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVAIIJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVAIIJF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 03:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVAIIJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 03:09:05 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:53597 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261565AbVAIIJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 03:09:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=hlivuZ1sk9Kp9v85BnWk5Uc+IJE8BO9E9bF/ZpvVf3Te955Bs++vS8NWZ/JOpntwkbiTrucu1RnHwFdoYcRQnY3xeB5nd8waM9LVGbC6kGGpgl9YSgsyVUf5GwjE6p/1Qp5Aw98h9B1Dz/hXS9O3iM5N919zQdBnG5tmFe2hCaY=
Message-ID: <1ab49290050109000913bb0b2@mail.gmail.com>
Date: Sun, 9 Jan 2005 00:09:01 -0800
From: Matthew Trent <t3rmin@gmail.com>
Reply-To: Matthew Trent <t3rmin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: CPUFreq chokes on Sempron
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When loading the powernow-k8 module on any recent kernel (I've tried
2.6.8 through 2.6.10) on my Sempron laptop, I see:
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09e)
powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x6 (1400 mV)
powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x18 (950 mV)
cpu_init done, current fid 0x8, vid 0x4
powernow-k8: vid trans failed, vid 0x3, curr 0x4
powernow-k8: transition frequency failed
powernow-k8: vid trans failed, vid 0x3, curr 0x4
powernow-k8: transition frequency failed

... and many more of those 'vid trans failed' errors (one every time
there's an attempted freq change).

There is a small patch available at...
http://ubuntuforums.org/archive/index.php/t-3585.html
...which seems to fix the problem. Should this be included into the
kernel officially?
-- 
Matthew Trent
