Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUIFVIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUIFVIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 17:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUIFVIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 17:08:13 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:14343 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265093AbUIFVIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 17:08:12 -0400
Date: Mon, 6 Sep 2004 22:08:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Hirokazu Takata <takata@linux-m32r.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc1-mm3] [m32r] Modify sys_ipc() to remove useless iBCS2 support code
Message-ID: <20040906220807.A9450@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-kernel@vger.kernel.org
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903105423.A3179@infradead.org> <20040906.214051.336469534.takata.hirokazu@renesas.com> <20040906140209.05416fe6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040906140209.05416fe6.akpm@osdl.org>; from akpm@osdl.org on Mon, Sep 06, 2004 at 02:02:09PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 02:02:09PM -0700, Andrew Morton wrote:
> Hirokazu Takata <takata@linux-m32r.org> wrote:
> >
> > The useless iBCS2 supporting code is removed.
> 
> I didn't really understand what Christoph was saying about this one, so
> I'll apply it for now.

iBCS2 is a standard for binary compatiblity on x86.  The x86 SysV IPC code
has hacks in there so it could be used by applications for x86 SVR3/4 system
under binary emulation aswell.  This is obviously useless for any non-x86
port, but lots of people blindly copied it.

