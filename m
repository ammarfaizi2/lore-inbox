Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbTI1QnM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 12:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbTI1QnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 12:43:12 -0400
Received: from postoffice9.mail.cornell.edu ([132.236.56.39]:11154 "EHLO
	postoffice9.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S262613AbTI1QnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 12:43:08 -0400
Message-ID: <3F770F88.7050904@cornell.edu>
Date: Sun, 28 Sep 2003 12:42:48 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030829 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alsa-devel@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This release broke ALSA for me. OSS emulation continued to work for 
xmms, but not for wine. The via_82xx driver told me to try 
dxs_support=1, so I did and it works again.

This is an ALC650-based:

00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235 AC97 Audio Controller (rev 50)

(I'm sorry if this is a second post to LKML - mailer problems)

> Jaroslav Kysela:
>   o ALSA CVS updates
>     - clean up the usage of the size variable and removes size1.
>     - define AD198x bits.
>     - add descriptions for whole-frag and no-silence commands.
>     - use dxs_support=3 (48k fixed) as default, since there are so many problems
>       with dxs_support=0.
>     - add the support for stereo mute switches on AD198x.
>     - initialize tumbler/snapper audio via gpio before i2c initialization.
>     - add check of DXS supports (so far, empty).
>     - add detection of revision of ALC650 chip
>     - get_page() fix
>     - fix the SPDIF bit on aureon boards.
>     - set 48k only for the sample rate of SPDIF on nForce.
>     - kill of not-required version.h inclusion
>     - Remove duplicated include
>     - fix buffer overlap on FX8010 PCM.
>     - Fix hwdep hotplug problem
>     - Use try_module_get() and module_put() to block the toplevel module
>     - Fix returned error code in the release() callback
>     etc
> 

