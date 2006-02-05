Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWBESqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWBESqb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 13:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWBESqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 13:46:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47531 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751155AbWBESqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 13:46:31 -0500
Date: Sun, 5 Feb 2006 18:46:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] x86_64: unexport ia32_sys_call_table
Message-ID: <20060205184629.GA4791@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <20060205182930.GA15767@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205182930.GA15767@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 07:29:30PM +0100, Adrian Bunk wrote:
> This export doesn't seem to do anything but bloating the kernel by
> a few bytes.

ACK. The native syscall table isn't exported, so the 32bit compat one
shouldn't either - and afaik isn't on any other port.

