Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270577AbTGTAma (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 20:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270579AbTGTAma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 20:42:30 -0400
Received: from rrcs-west-24-24-160-174.biz.rr.com ([24.24.160.174]:15045 "EHLO
	pacserv.unco.de") by vger.kernel.org with ESMTP id S270577AbTGTAm3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 20:42:29 -0400
Date: Sat, 19 Jul 2003 17:57:26 -0700
From: Hielke Christian Braun <hcb@unco.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 cryptoloop & aes
Message-ID: <20030720005726.GA735@jolla>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i try to test the cryptoloop in 2.6.0-test1. I have enabled:

CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_AES=y

Then i installed the losetup from util-linux-2.12pre. When i setup
the device like this:

/lib/losetup -e aes /dev/loop5 /dev/hda4

I get:

Unsupported encryption type aes

cat /proc/crypto:

name         : aes
module       : kernel
blocksize    : 16
min keysize  : 16
max keysize  : 32
ivsize       : 16


Is the cryptoloop in 2.6.0 not usable yet? 



Regards,
 Christian





