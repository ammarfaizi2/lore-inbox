Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267253AbUG1P5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267253AbUG1P5A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267275AbUG1Pzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:55:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60908 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267242AbUG1Pxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:53:50 -0400
Date: Wed, 28 Jul 2004 08:51:50 -0700
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: fix some 32bit isms
Message-Id: <20040728085150.4331f2db.davem@redhat.com>
In-Reply-To: <20040728135941.GA17409@devserv.devel.redhat.com>
References: <20040728135941.GA17409@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004 09:59:41 -0400
Alan Cox <alan@redhat.com> wrote:

> Fairly self explanatory. int is not size_t.

And size_t is not "%ld" either.

> -				"failed (%d bytes)\n",
> +				"failed (%ld bytes)\n",

Rather, it is either "%Zd" or "%zd".  Please fix :-)
