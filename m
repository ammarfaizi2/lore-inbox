Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUFEVOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUFEVOR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 17:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUFEVOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 17:14:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:29385 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262422AbUFEVOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 17:14:10 -0400
Date: Sat, 5 Jun 2004 23:14:09 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] compat bug in sys_recvmsg, MSG_CMSG_COMPAT check missing
Message-ID: <20040605211409.GC1134@suse.de>
References: <20040605204334.GA1134@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040605204334.GA1134@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Jun 05, Olaf Hering wrote:

> 
> packet_recvmsg() gets the flags from the compat_sys_socketcall(), but it
> does not check for the active MSG_CMSG_COMPAT bit. As a result, it
> returns -EINVAL and makes the user rather unhappy

possible related bugs are in:

ipx_sendmsg
pfkey_recvmsg
x25_sendmsg
ax25_sendmsg
irda_sendmsg
irda_sendmsg_dgram
irda_sendmsg_ultra
rose_sendmsg
atalk_sendmsg
dn_recvmsg
dn_sendmsg
econet_sendmsg
wanpipe_sendmsg
nr_sendmsg


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
