Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270954AbRHOALX>; Tue, 14 Aug 2001 20:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270958AbRHOALN>; Tue, 14 Aug 2001 20:11:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22087 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270954AbRHOAK6>; Tue, 14 Aug 2001 20:10:58 -0400
Date: Wed, 15 Aug 2001 02:11:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Tim Hockin <thockin@sun.com>
Cc: "David S. Miller" <davem@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: poll change
Message-ID: <20010815021110.F4304@athlon.random>
In-Reply-To: <3B79B381.58266C13@sun.com> <20010814.162710.131914269.davem@redhat.com> <3B79B5F3.C816CBED@sun.com> <20010814.163804.66057702.davem@redhat.com> <3B79BA07.B57634FD@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B79BA07.B57634FD@sun.com>; from thockin@sun.com on Tue, Aug 14, 2001 at 04:53:43PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 04:53:43PM -0700, Tim Hockin wrote:
> -	if (nfds > NR_OPEN)
> +	if (nfds > current->rlim[RLIMIT_NOFILE].rlim_cur)

Here SuS speaks about OPEN_MAX, not sure if OPEN_MAX corresponds to the
current ulimit or to the absolute maximum (to me it sounds more like our
NR_OPEN).

Andrea
