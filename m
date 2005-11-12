Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVKLGHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVKLGHE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 01:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVKLGHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 01:07:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932153AbVKLGHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 01:07:02 -0500
Date: Fri, 11 Nov 2005 22:06:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] misc: Allow dropping panic text strings from
 kernel image
Message-Id: <20051111220646.7f5167d4.akpm@osdl.org>
In-Reply-To: <12.282480653@selenic.com>
References: <11.282480653@selenic.com>
	<12.282480653@selenic.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> Configurable support for panic strings

This does make a bit of a mess.  You could lose one ifdef by leaving `buf'
present in panic(), as

	static char buf[1];

But still, a bit more inventiveness is needed, IMO.
