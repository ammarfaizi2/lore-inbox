Return-Path: <linux-kernel-owner+w=401wt.eu-S1751129AbXARASA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbXARASA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 19:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbXARASA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 19:18:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55231 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbXARASA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 19:18:00 -0500
Date: Thu, 18 Jan 2007 00:17:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Ulrich Drepper <drepper@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH 2.6.20-rc5 4/4] sys_futex64 : allows 64bit futexes
Message-ID: <20070118001758.GB17257@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pierre Peiffer <pierre.peiffer@bull.net>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Ulrich Drepper <drepper@redhat.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Jean-Pierre Dion <jean-pierre.dion@bull.net>
References: <45ADDF60.5080704@bull.net> <45ADE6B5.8050402@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45ADE6B5.8050402@bull.net>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 10:04:53AM +0100, Pierre Peiffer wrote:
> Hi,
> 
> This latest patch is an adaptation of the sys_futex64 syscall provided in 
> -rt
> patch (originally written by Ingo). It allows the use of 64bit futex.

Big NACK here, we don't need yet another goddamn multiplexer.  Please
make this individual syscalls for the actual operations.

> +	if (!ret) {
> +		switch (cmp) {
> +		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
> +		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;

Please indent this properly, the ret = .. and reak need to go onto
a line on it's own.

