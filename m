Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVFOIoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVFOIoM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 04:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVFOIoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 04:44:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:13770 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261329AbVFOIoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 04:44:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Roy Lee <roylee17@gmail.com>
Subject: Re: One question about fork, vfork and clone
Date: Wed, 15 Jun 2005 10:41:42 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <42AFE410.4020803@gmail.com>
In-Reply-To: <42AFE410.4020803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506151041.44365.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 15 Juni 2005 10:17, Roy Lee wrote:
> is this means the library calls no more wrap the sys_clone() for the
> three library call(fork,vfork,clone), but
> call the corresponding syscall? or it never did that?

The sys_vfork and sys_fork entry points are there so old libc versions
can still work. Some architectures that were added after sys_clone
was introduced wrongly copied this code, but new architectures that
get added should just provide sys_clone and have the other calls
implemented as wrappers in libc.

	Arnd <><
