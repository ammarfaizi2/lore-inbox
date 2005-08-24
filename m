Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVHXWlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVHXWlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 18:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVHXWlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 18:41:36 -0400
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:12493 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S932346AbVHXWle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 18:41:34 -0400
Date: Wed, 24 Aug 2005 18:41:26 -0400 (EDT)
Message-Id: <200508242241.j7OMfQ1g012200@ms-smtp-01.rdc-nyc.rr.com>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-URL: mailto:linux-kernel@vger.kernel.org
X-Mailer: Lynx, Version 2.8.6dev.13b
From: robotti@godmail.com
Subject: Initramfs and TMPFS!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   >>On Wed, Aug 24, 2005 at 04:52:37PM -0400, Wakko Warner wrote:
   >>Care to send me the patch?
   >Heh. Not really as I don't really know if people should be using it
   >in it's current state --- the shmem init is very very hacky and I have
   >other changes I've not had a chance to do.
   >Anyhow, here is an older version of it. It's from some old internal
   >embedded tree but should be trivial to shoehorn into anything recent.
   >If people really do like or want this I would like to know and maybe
   >something more elegant can be worked out.

I tried it with kernel 2.6.13-rc5 and it seems to work.

It uses 50% of total memory for tmpfs, but it would be nice to have
an option (tmpfs_size=90% etc.) that you could pass to the kernel.

You need to add this to init/main.c for it to compile.
#include <asm/uaccess.h>
