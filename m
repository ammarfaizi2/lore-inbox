Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbVDAUnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbVDAUnN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVDAUnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:43:13 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:8888
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262873AbVDAUgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:36:13 -0500
Date: Fri, 1 Apr 2005 12:35:20 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       matthew@wil.cx
Subject: Re: [PATCH] Fix SELinux for removal of i_sock
Message-Id: <20050401123520.7532528b.davem@davemloft.net>
In-Reply-To: <1112385997.14481.192.camel@moss-spartans.epoch.ncsc.mil>
References: <1112385997.14481.192.camel@moss-spartans.epoch.ncsc.mil>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Apr 2005 15:06:37 -0500
Stephen Smalley <sds@tycho.nsa.gov> wrote:

> This patch against -bk eliminates the use of i_sock by SELinux as it
> appears to have been removed recently, breaking the build of SELinux in
> -bk.  Simply replacing the i_sock test with an S_ISSOCK test would be
> unsafe in the SELinux code, as the latter will also return true for the
> inodes of socket files in the filesystem, not just the actual socket
> objects IIUC.  Hence this patch reworks the SELinux code to avoid the
> need to apply such a test in the first place, part of which was
> obsoleted anyway by earlier changes to SELinux.  Please apply.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by:  James Morris <jmorris@redhat.com>

Applied, thanks Stephen.
