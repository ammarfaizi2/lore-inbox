Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWCTOaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWCTOaI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 09:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWCTOaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 09:30:08 -0500
Received: from quechua.inka.de ([193.197.184.2]:23957 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S964814AbWCTOaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 09:30:06 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: Announcing crypto suspend
To: linux-kernel@vger.kernel.org
Date: Mon, 20 Mar 2006 15:13:33 +0100
References: <20060320080439.GA4653@elf.ucw.cz>
User-Agent: KNode/0.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20060320141244.80A55127677@dungeon.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Thanks to Rafael's great work, we now have working encrypted suspend
> and resume. You'll need recent -mm kernel, and code from
> suspend.sf.net. Due to its use of RSA, you'll only need to enter
> password during resume.

so, how does it work? what is new? how is it different from alternative?
with suspend2 and dm-crypt I have encrypted supend too:
 - one boot partition (plain), one root partition
 - root partition is on dm-crypt. initramfs has tools to set it up.
 - swap file on root parition
 - suspend to that swap file.
 - initramfs could first ask for the passphrase to an rsa key,
   the key decrypts a binary file, the decrypted binary is the
   dm-crypt key.
 - resume could be triggered once the new root was mounted and
   in place. 
 - usb access etc. should work as well in the initramfs, so I
   could move the rsa key to my smart card as well.

haveing something similar in mainline would be a huge help.

Andreas

