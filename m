Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVFHUMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVFHUMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 16:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVFHUMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 16:12:36 -0400
Received: from mail.linicks.net ([217.204.244.146]:56581 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261595AbVFHUMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 16:12:30 -0400
From: Nick Warne <nick@linicks.net>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: mtrr question
Date: Wed, 8 Jun 2005 21:12:20 +0100
User-Agent: KMail/1.8.1
References: <200506081917.09873.nick@linicks.net> <200506082047.13914.nick@linicks.net> <20050608195336.GL876@redhat.com>
In-Reply-To: <20050608195336.GL876@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506082112.20194.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 20:53, Dave Jones wrote:
> Maybe. I don't use non-free drivers, so I have no idea
> what nvidia are/aren't doing in their driver.
>
> I'd suggest trying the nvidia forums.

No need ;-).  You helped me pinpoint it... I went for it and ran manually:

bash-2.05b# echo "base=0xD0000000 size=0x4000000 type=write-combining" 
>| /proc/mtrr

bash-2.05b# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0x40000000 (1024MB), size= 256MB: write-back, count=1
reg02: base=0xd0000000 (3328MB), size=  64MB: write-combining, count=1
reg05: base=0xc0000000 (3072MB), size= 256MB: write-combining, count=1

Thanks for help Dave... very much appreciated.  I will look back and use Linux 
kernel module next build - I want things be nice and free too.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
