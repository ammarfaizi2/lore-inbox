Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbSJWQzO>; Wed, 23 Oct 2002 12:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265089AbSJWQzN>; Wed, 23 Oct 2002 12:55:13 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:13326 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265092AbSJWQyz>; Wed, 23 Oct 2002 12:54:55 -0400
Date: Wed, 23 Oct 2002 18:01:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Matt D. Robinson" <yakker@aparity.com>
Cc: linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
Subject: Re: [PATCH] LKCD for 2.5.44 (6/8): dump trace/dump calls/dump_in_progress
Message-ID: <20021023180105.B16547@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Matt D. Robinson" <yakker@aparity.com>,
	linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
References: <Pine.LNX.4.44.0210230241050.27315-100000@nakedeye.aparity.com> <Pine.LNX.4.44.0210230244300.27315-100000@nakedeye.aparity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210230244300.27315-100000@nakedeye.aparity.com>; from yakker@aparity.com on Wed, Oct 23, 2002 at 02:44:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 02:44:43AM -0700, Matt D. Robinson wrote:
> +#if !defined(CONFIG_CRASH_DUMP) && !defined(CONFIG_CRASH_DUMP_MODULE)
>  #ifdef CONFIG_SMP
>  	smp_send_stop();
>  #endif
> +#endif

Again, is there a chance you could make this a runtime switch?
This would allow to poweroff dump-enabled kernel not configured for
dumping.

