Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265645AbTFSA1f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbTFSA1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:27:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44525 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265645AbTFSA1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:27:34 -0400
Date: Thu, 19 Jun 2003 01:41:30 +0100
From: Joel Becker <jlbec@evilplan.org>
To: John Myers <jgmyers@netscape.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [PATCH 2.5.71-mm1] aio process hang on EINVAL
Message-ID: <20030619004130.GP7895@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	John Myers <jgmyers@netscape.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-aio@kvack.org" <linux-aio@kvack.org>
References: <1055810609.1250.1466.camel@dell_ss5.pdx.osdl.net> <3EEE6FD9.2050908@netscape.com> <20030617085408.A1934@in.ibm.com> <1055884008.1250.1479.camel@dell_ss5.pdx.osdl.net> <3EEFAC58.905@netscape.com> <20030618001534.GJ7895@parcelfarce.linux.theplanet.co.uk> <3EEFB165.5070208@netscape.com> <20030618004214.GK7895@parcelfarce.linux.theplanet.co.uk> <3EF104D7.5050905@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF104D7.5050905@netscape.com>
User-Agent: Mutt/1.4.1i
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 05:33:27PM -0700, John Myers wrote:
> The kernel would have to be substantially more complex to report all 
> errors that could possibly be detected during queuing.  The kernel could 
> even detect success during queuing if it really tried.

	The slippery slope isn't important.  POSIX specifies EAGAIN
(you concede that), EBADF, and EINVAL against nbytes|offset|reqprio.
The kernel does these checks already (where applicable).
	Anyway, a caller of io_submit() already has to handle errors.
Just like a short read, you always have to be wary of them.

Joel

-- 

"Glory is fleeting, but obscurity is forever."  
         - Napoleon Bonaparte

			http://www.jlbec.org/
			jlbec@evilplan.org
