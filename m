Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbUKONgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbUKONgK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 08:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUKONgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 08:36:10 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:33408 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261596AbUKONfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 08:35:51 -0500
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
	using SELinux and SOCK_SEQPACKET
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
Cc: netdev@oss.sgi.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4197A037.1020307@blueyonder.co.uk>
References: <4197A037.1020307@blueyonder.co.uk>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1100525477.31773.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 15 Nov 2004 08:31:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-14 at 13:13, Ross Kendall Axe wrote:
> With CONFIG_SECURITY_NETWORK=y and CONFIG_SECURITY_SELINUX=y, using
> SOCK_SEQPACKET unix domain sockets causes an oops in the superfluous(?)
> call to security_unix_may_send in sock_dgram_sendmsg. This patch avoids
> making this call for SOCK_SEQPACKET sockets.

I'd prefer to track down the actual issue in the SELinux code and
correct it than just omit the security hook call entirely.  Do you have
the Oops output and a trivial test case?  Thanks.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

