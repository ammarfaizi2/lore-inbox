Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267649AbUHSAJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267649AbUHSAJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 20:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267660AbUHSAJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 20:09:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43917 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267649AbUHSAJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 20:09:06 -0400
Date: Wed, 18 Aug 2004 17:06:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: joshk@triplehelix.org (Joshua Kwan)
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] busybox EFAULT on sparc64
Message-Id: <20040818170600.035e2345.davem@redhat.com>
In-Reply-To: <20040818235528.GA8070@triplehelix.org>
References: <20040818235528.GA8070@triplehelix.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 16:55:28 -0700
joshk@triplehelix.org (Joshua Kwan) wrote:

> I'm inclined to believe that the two bugs are related; these both happen
> with busybox-cvs and the exact same programs work with 2.4. Bastian
> Blank suggests that it is the compat wrapper for sys_mount that is not
> clean.

I think this analysis is faulty, all of the userspace accesses done
by the compat layer for sys_mount() are done exactly using the same
code the normal sys_mount() uses, namely copy_mount_options().
