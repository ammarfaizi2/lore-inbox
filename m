Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271638AbTGQXud (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 19:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271639AbTGQXud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 19:50:33 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:1686 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id S271638AbTGQXub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 19:50:31 -0400
Date: Thu, 17 Jul 2003 17:04:45 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrew Morton <akpm@osdl.org>, miquels@cistron.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030718000444.GG19891@ca-server1.us.oracle.com>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	Andrew Morton <akpm@osdl.org>, miquels@cistron.nl,
	linux-kernel@vger.kernel.org
References: <20030716184609.GA1913@kroah.com> <20030717014410.A2026@pclin040.win.tue.nl> <20030716164917.2a7a46f4.akpm@osdl.org> <20030717122600.A2302@pclin040.win.tue.nl> <bf5uqb$3ei$1@news.cistron.nl> <20030717131955.D2302@pclin040.win.tue.nl> <20030717145507.3ce5042c.akpm@osdl.org> <20030718002451.A2569@pclin040.win.tue.nl> <20030717224307.GF19891@ca-server1.us.oracle.com> <20030718011115.A2600@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718011115.A2600@pclin040.win.tue.nl>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 01:11:15AM +0200, Andries Brouwer wrote:
> :-) A surprising question.
> Why expand that?
> Because we would like to use more than 16 bits in device numbers.

	Yes, but there is a nice simplicity in saying filesystems that
support 64bit device numbers get the expanded space, and filesystems
that cannot are limited to 16bits.  Most modern systems would have an
updated set of filesystems.  All pre-existing filesystems have only
16bit device numbers.  All new mknod64() calls will only work on
filesystems that can store 64bits.

Joel

-- 

"Hey mister if you're gonna walk on water,
 Could you drop a line my way?"

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
