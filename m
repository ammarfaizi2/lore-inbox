Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbTAUSuR>; Tue, 21 Jan 2003 13:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267179AbTAUSuR>; Tue, 21 Jan 2003 13:50:17 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:34825 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267178AbTAUSuP>; Tue, 21 Jan 2003 13:50:15 -0500
Date: Tue, 21 Jan 2003 18:59:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [PATCH (take 2)][2.5] hangcheck-timer
Message-ID: <20030121185921.A2322@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joel Becker <Joel.Becker@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Wim Coekaerts <Wim.Coekaerts@oracle.com>
References: <20030121011954.GO20972@ca-server1.us.oracle.com> <20030121081158.A21080@infradead.org> <20030121173303.GU20972@ca-server1.us.oracle.com> <20030121184403.GY20972@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030121184403.GY20972@ca-server1.us.oracle.com>; from Joel.Becker@oracle.com on Tue, Jan 21, 2003 at 10:44:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <linux/smp_lock.h>

not needed anymore.

> +MODULE_AUTHOR("Joel Becker");
> +MODULE_LICENSE("GPL");

What about a MODULE_DESCRIPTION()?

> +static struct timer_list hangcheck_ticktock = {
> +	function:	hangcheck_fire,
> +};

Use C99 initializers instead.

> +}  /* hangcheck_init() */

These comments are a bit against the usual kernel coding style,
espececially for that short function..

p.s. sorry for not noticing some of the stuff earlier
