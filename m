Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262923AbUKRWx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbUKRWx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbUKRWv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:51:28 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:40081
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262923AbUKRWud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 17:50:33 -0500
Date: Thu, 18 Nov 2004 14:34:51 -0800
From: "David S. Miller" <davem@davemloft.net>
To: James Morris <jmorris@redhat.com>
Cc: chrisw@osdl.org, ross.axe@blueyonder.co.uk, netdev@oss.sgi.com,
       sds@epoch.ncsc.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
Message-Id: <20041118143451.3dae3ffb.davem@davemloft.net>
In-Reply-To: <Xine.LNX.4.44.0411181219590.5236-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0411181158110.5096-100000@thoron.boston.redhat.com>
	<Xine.LNX.4.44.0411181219590.5236-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004 12:25:21 -0500 (EST)
James Morris <jmorris@redhat.com> wrote:

> Updated patch below (with Chris Wright's wrapper idea).
> 
> This now fixes both issues.
> 
> 1) Don't call security_unix_may_send() hook during sendmsg() for 
> SOCK_SEQPACKET, and ensure that sendmsg() can only be called on a 
> connected socket so as not to bypass the security_unix_stream_connect() 
> hook.
> 
> 2) Return -EINVAL if sendto() is called on SOCK_SEQPACKET with an address 
> supplied.
> 
> Please review and apply if ok.
> 
> 
> Signed-off-by: James Morris <jmorris@redhat.com>

Looks good, applied thanks James.
