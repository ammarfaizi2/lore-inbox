Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUJWJIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUJWJIj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 05:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUJWJIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 05:08:38 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:36087 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S261405AbUJWJId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 05:08:33 -0400
Subject: Re: 2.6.9-mm1
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com, rddunlap@osdl.org
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
References: <20041022032039.730eb226.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1098522510.626.47.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 11:08:30 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   - kexec and crashdump: this all allegedly works, but I want to *see* it
>     work first.

- sys_reboot() calls device_shutdown() which naturally makes my disks go
to sleep and immediatly after spin up when the disk initialization code
comes in. Is there some specific reason why this is needed? Appears to
work for me just removing the function call.

- 3c59x driver together with my 3c509C-TX card hits:
"ff:ff:ff:ff:ff:ff<3>*** EEPROM MAC address invalid"
after doing a kexec-reboot. I tried reseting it at bootup but I couldn't
get it kicking. I couldn't find any specs nor maintainer for this one...


I'll play a bit more with this.
Anywhere I can fetch experimental amd64 patches if there are any?


Alexander

