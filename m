Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbTE1Jc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 05:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbTE1Jc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 05:32:56 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:60432 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264635AbTE1Jcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 05:32:55 -0400
Date: Wed, 28 May 2003 10:46:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Roskin <proski@gnu.org>
Cc: devfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Graceful failure in devfs_remove() in 2.5.x
Message-ID: <20030528104603.A27503@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Roskin <proski@gnu.org>, devfs@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.55.0305271105110.1412@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.55.0305271105110.1412@marabou.research.att.com>; from proski@gnu.org on Tue, May 27, 2003 at 11:29:53AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 11:29:53AM -0400, Pavel Roskin wrote:
> This patch makes devfs_remove() print an error to the kernel log and
> continue.  PRINTK is defined in fs/devfs/base.c to report errors in the
> cases like this one:

Patch looks okay _except_ for use of this gross macro.  Just
ise plain printk instead.
