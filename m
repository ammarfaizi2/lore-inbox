Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263874AbTEZChH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 22:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTEZChG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 22:37:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28304 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263874AbTEZChG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 22:37:06 -0400
Date: Mon, 26 May 2003 03:50:16 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: netlink init order
Message-ID: <20030526025016.GM6270@parcelfarce.linux.theplanet.co.uk>
References: <20030525.190710.112599236.davem@redhat.com> <Pine.LNX.4.44.0305251922310.1621-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305251922310.1621-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 07:22:56PM -0700, Linus Torvalds wrote:

> +__initcall(init_netlink);
> +__exitcall(cleanup_netlink);

Err...  That should be

+module_init(init_netlink)
+module_exit(cleanup_netlink)
