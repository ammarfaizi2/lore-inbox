Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUDENCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 09:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUDENCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 09:02:54 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:27662 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262351AbUDENCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 09:02:52 -0400
To: James Vega <vega_james@lycos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fat32 all upper-case filename problem
References: <4070910E.7020808@lycos.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 05 Apr 2004 22:02:44 +0900
In-Reply-To: <4070910E.7020808@lycos.com>
Message-ID: <87k70utw5n.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Vega <vega_james@lycos.com> writes:

> debil% touch /usbdrive/CASE
> debil% ls /usbdrive
> case
> debil% ls /usbdrive/CASE
> /usbdrive/CASE
> debil% ls /usbdrive/case
> /usbdrive/case
> debil% umount /usbdrive && mount /usbdrive
> debil% ls /usbdrive/case
> /usbdrive/case
> debil% ls /usbdrive/CASE
> ls: /usbdrive/CASE: No such file or directory

Are you using the "iocharset=utf8" or CONFIG_NLS_DEFAULT="utf8"?
If so, it's buggy.

Please don't use it for now.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
