Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbUC2L3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 06:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbUC2L3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 06:29:46 -0500
Received: from smtp1.freeserve.com ([193.252.22.158]:17971 "EHLO
	mwinf3001.me.freeserve.com") by vger.kernel.org with ESMTP
	id S262819AbUC2L3m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 06:29:42 -0500
Message-ID: <26889266.1080559781017.JavaMail.www@wwinf3002>
From: tigran@aivazian.fsnet.co.uk
Reply-To: tigran@aivazian.fsnet.co.uk
To: Marco Baan <marco@freebsd.nl>
Subject: Re: failure to mount root fs
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [62.172.234.2]
Date: Mon, 29 Mar 2004 13:29:41 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Macro,

You wrote:

> VFS: Unable to mount root fs on unknown-block(0,0)
> ...
> kernel /boot/bzImage-2.6.4 ro root=LABEL=/

The "LABEL=/" is the attempt to mount root filesystem by label, so you can 
move it to another disk. I find these "clever" things not mature yet and always replace it by an explicit device name (and don't move/replace root disk):

kernel /boot/bzImage-2.6.4 ro root=/dev/hda2

(this assumes that your root fs is on /dev/hda2, change it appropriately to match your situation)

Kind regards
Tigran
Freeserve AnyTime - HALF PRICE for the first 3 months - Save £7.50 a month 
www.freeserve.com/anytime
