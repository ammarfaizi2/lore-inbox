Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTLBUWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbTLBUW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:22:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:51432 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264358AbTLBUV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:21:28 -0500
Subject: Re: aacraid and large memory problem (2.6.0-test11)
From: Mark Haverkamp <markh@osdl.org>
To: Kevin Fenzi <kevin@tummy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
In-Reply-To: <20031202193520.74481F7CC8@voldemort.scrye.com>
References: <20031202193520.74481F7CC8@voldemort.scrye.com>
Content-Type: text/plain
Message-Id: <1070396482.16903.11.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 02 Dec 2003 12:21:22 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-02 at 11:35, Kevin Fenzi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Greetings, 
> 
> Booting 2.6.0-test11 on a machine with 8GB memory and using the
> aacraid driver results in a hang on boot. Passing mem=2048M causes it
> to boot normally. 4GB also hangs. 2.6.0-test8 booted normally on this
> same hardware. 
> 
> 8GB memory, dual xeon 3.06mhz with hyperthreading, RedHat 9 on it
> currently. 
> 
> Happy to provide details on setup/software, etc. 
> 
> Perhaps this patch in 2.6.0-test9 is the culprit?
> http://www.linuxhq.com/kernel/v2.6/0-test9/drivers/scsi/aacraid/comminit.c

This patch is what made aacraid work with over 4 gig of memory for me. 
I have an 8 proc system with 16gig of memory and without this patch I
get data corruption in high memory.

I don't boot on the aacraid though.


-- 
Mark Haverkamp <markh@osdl.org>

