Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261665AbTCPXqQ>; Sun, 16 Mar 2003 18:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261668AbTCPXqQ>; Sun, 16 Mar 2003 18:46:16 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:29964 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261665AbTCPXqP>; Sun, 16 Mar 2003 18:46:15 -0500
Date: Sun, 16 Mar 2003 23:57:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] Increase efficiency of CONFIG_NET=n
Message-ID: <20030316235708.A30119@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org
References: <20030316214334.GR29631@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030316214334.GR29631@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Sun, Mar 16, 2003 at 09:43:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 09:43:34PM +0000, Matthew Wilcox wrote:
> +asmlinkage long sys_socket(int family, int type, int protocol)
> +{
> +	return -ENOSYS;
> +}

Please just use cond_syscall in kernel/sys.c for all this stubbed
out syscalls.

