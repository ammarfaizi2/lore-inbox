Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265563AbTFZKx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 06:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265565AbTFZKx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 06:53:56 -0400
Received: from mail.convergence.de ([212.84.236.4]:40939 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S265563AbTFZKxz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 06:53:55 -0400
Message-ID: <3EFAD416.3080901@convergence.de>
Date: Thu, 26 Jun 2003 13:08:06 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: "Zeno R.R. Davatz" <zdavatz@ywesee.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: INIT:ld"2" respawning too fast:disabled for 5 minutes
References: <36993D449C7FA647BF43568E0793AB3E061D2D@nevis_pune_xchg.pune.nevisnetworks.com> <20030626122507.71667b15.zdavatz@ywesee.com>
In-Reply-To: <20030626122507.71667b15.zdavatz@ywesee.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zeno,

> NB: I get the same error with the Debian Kernel-Source-2.4.20...

Are you using devfs? If so and you don't have the devfsd running, then 
there won't be any /dev/ttyX devices and the init process will try to 
spawn new consoles unless it gives up with the error message you described.

Make sure to disable devfs support in the kernel in that case. Then 
you'll have the proper /dev/ttyX entries and init can spawn the 
processes without problems.

CU
Michael.

