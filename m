Return-Path: <linux-kernel-owner+w=401wt.eu-S1753348AbWLRGKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbWLRGKF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 01:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbWLRGKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 01:10:05 -0500
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:51851 "EHLO
	liaag1ae.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753348AbWLRGKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 01:10:04 -0500
Date: Mon, 18 Dec 2006 01:03:08 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: 2.6.19.1 bug?  tar: file changed as we read it
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-cifs-client <linux-cifs-client@lists.samba.org>,
       Steve French <sfrench@samba.org>, Andrew Morton <akpm@osdl.org>
Message-ID: <200612180106_MC3-1-D56B-FD2F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to backup up a filesystem mounted via CIFS, I got these messages
from tar:

tar: t/2.6.10-orig/net/ipv4/netfilter/ipt_CONNMARK.c: File shrank by 1178 bytes; padding with zeros
tar: t/2.6.10-orig/net/ipv4/netfilter/ipt_TCPMSS.c: File shrank by 4177 bytes; padding with zeros
tar: t/2.6.10-orig/net/ipv4/netfilter/ipt_DSCP.c: File shrank by 1172 bytes; padding with zeros
tar: t/2.6.10-orig/net/ipv4/netfilter/ipt_tos.c: file changed as we read it
tar: t/2.6.10-orig/net/ipv4/netfilter/ipt_ECN.c: File shrank by 1638 bytes; padding with zeros
tar: t/2.6.10-orig/net/ipv4/netfilter/ipt_mark.c: file changed as we read it
tar: t/2.6.10-orig/net/ipv6/netfilter/ip6t_mark.c: file changed as we read it

This was with kernel 2.6.19.1 SMP on x86_64, creating a tar file on a local
jfs filesystem (t is the source path on a cifs mount.)

Using 2.6.18.6-pre2 uniprocessor i386, with smbfs instead of cifs, everything
works fine so I'm pretty sure the server is OK.

Does this match any known problems?

-- 
MBTI: IXTP
