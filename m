Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263430AbTHXK4G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 06:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTHXK4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 06:56:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20416 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263430AbTHXK4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 06:56:03 -0400
Date: Sun, 24 Aug 2003 03:47:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test4][NET] 3c509.c: remove device.name field
Message-Id: <20030824034735.534b8c68.davem@redhat.com>
In-Reply-To: <1061644409.1141.18.camel@lima.royalchallenge.com>
References: <1061644409.1141.18.camel@lima.royalchallenge.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Aug 2003 18:43:29 +0530
Vinay K Nallamothu <vinay-rc@naturesoft.net> wrote:

> This patch removes the device name field which is no longer present.

This doesn't look like the right fix.  You can't just
delete these lines, you should rather replace them with
accesses to whatever the MCA device struct name field is.
