Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264198AbUEMNwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbUEMNwC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 09:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264199AbUEMNwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 09:52:02 -0400
Received: from mail0-105.ewetel.de ([212.6.122.105]:47500 "EHLO
	mail0.ewetel.de") by vger.kernel.org with ESMTP id S264198AbUEMNwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 09:52:00 -0400
To: Kalin KOZHUHAROV <kalin@ThinRope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Too restrictive permissions on some files prevent non-root build  (with KBUILD_OUTPUT) [bug 2669]
In-Reply-To: <1VorQ-6xx-13@gated-at.bofh.it>
References: <1VorQ-6xx-13@gated-at.bofh.it>
Date: Thu, 13 May 2004 15:51:54 +0200
Message-Id: <E1BOGcs-00006u-7d@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004 15:30:14 +0200, you wrote in linux.kernel:

> For 2.6.6 the files in question can be found by:
> cd /sometempdir
> tar xjf linux-2.6.6.tar.bz2
> find linux-2.6.6 ! -perm -004 -exec ls -l {} \;

This can only be a problem when unpacking as root, otherwise all
files are owned by the user running tar, anyway. I guess most
people don't do their kernel work as root... and why should they?

The simple workaround is to unpack the tar archive as the user
planning to run the compile.

-- 
Ciao,
Pascal
