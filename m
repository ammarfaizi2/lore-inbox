Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265013AbTFYUPW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbTFYUPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:15:22 -0400
Received: from mailhost3.tudelft.nl ([130.161.180.83]:19150 "EHLO
	mailhost3.tudelft.nl") by vger.kernel.org with ESMTP
	id S265013AbTFYUPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:15:16 -0400
Message-ID: <3EFA0626.3060104@balpol.tudelft.nl>
Date: Wed, 25 Jun 2003 22:29:26 +0200
From: Thijs <thijs@balpol.tudelft.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030612
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-ac3
References: <2ltx.Us.17@gated-at.bofh.it>
In-Reply-To: <2ltx.Us.17@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since 2.4.21-ac2 i'm experiencing problems with Postfix on Debian 
Stable. Messages get corrupted while being handled by Postfix.

Vanilla 2.4.21 and 2.4.21-ac1 are fine, but 2.4.21-ac2/3 causes 
problems. Going back to ac1 resolves the issue. I tried kernels on 
several Debian servers, but all have the same problem. Could be it's 
something in postfix that emerges with this specific patch, but it's at 
least curious. I'm not too familiar with this matter unfortunately.

The only logentries i see are:

postfix/qmgr[399]: warning: active/0/4/04E5B17E3F: too many length bits, 
record type 255
postfix/qmgr[399]: warning: 04E5B17E3F: envelope records out of order
postfix/qmgr[399]: warning: saving corrupt file "04E5B17E3F" from queue 
"active" to queue "corrupt"
...or just...
postfix/smtp[536]: warning: corrupted queue file: active/C/7/C7AC317E3F

Tested on: Intel PPro, Intel Celeron, AMD Duron
Tested on: ext2 and ext3

All other programms seem to work fine, no other strange messages 
whatsoever...

Regards,

--Thijs Welman
Delft University of Technology, the Netherlands


