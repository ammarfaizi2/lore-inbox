Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbTJWSMA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 14:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTJWSL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 14:11:59 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:30217 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261476AbTJWSL6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 14:11:58 -0400
To: Chip <szarlada@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8 PROBLEM: codepage=850 doesn't work with mount
References: <3F97AD01.9030806@freemail.hu>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 24 Oct 2003 03:10:00 +0900
In-Reply-To: <3F97AD01.9030806@freemail.hu>
Message-ID: <871xt3su4n.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip <szarlada@freemail.hu> writes:

> Hi,
> 
> If you've got this line in your /etc/fstab:
> 
> /dev/hda5 /mnt/win_d vfat quiet,iocharset=iso8859-1,codepage=850,umask=0 0 0
> 
> You will get the following message during mount -a:
> 
> mount: wrong fs type, bad option, bad superblock on /dev/hda5,
>         or too many mounted file systems
> 
> I've chessed out that the problemataic part is the codepage=850. When
> I've removed it the mount goes ok.

I couldn't reproduce it. Could you send output of dmesg and .config.
It looks like it couldn't load nls_cp850.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
