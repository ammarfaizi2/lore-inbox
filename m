Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbULOVTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbULOVTC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 16:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbULOVTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 16:19:02 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:37773
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262494AbULOVS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 16:18:59 -0500
Date: Wed, 15 Dec 2004 13:14:05 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: netdev@oss.sgi.com, zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       shemminger@osdl.org, davem@redhat.com
Subject: Re: udp_poll breaks vpnc
Message-Id: <20041215131405.7f5308a5.davem@davemloft.net>
In-Reply-To: <20041215131342.21768388@lembas.zaitcev.lan>
References: <20041215131342.21768388@lembas.zaitcev.lan>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004 13:13:42 -0800
Pete Zaitcev <zaitcev@redhat.com> wrote:

> I found that the attached patch breaks VPNC. By looking at strace, it never
> gets any poll events about arriving encrypted data. It may be a bug in VPNC,
> but this is a rather old binary which I used even on 2.4...

Fixed by a followon patch which is in BK as of 2 weeks ago.
Basically, we were using UDP poll for RAW sockets by accident.
