Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264869AbTFRA2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 20:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265014AbTFRA2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 20:28:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62613 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264869AbTFRA2T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 20:28:19 -0400
Date: Wed, 18 Jun 2003 01:42:14 +0100
From: Joel Becker <jlbec@evilplan.org>
To: John Myers <jgmyers@netscape.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [PATCH 2.5.71-mm1] aio process hang on EINVAL
Message-ID: <20030618004214.GK7895@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	John Myers <jgmyers@netscape.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-aio@kvack.org" <linux-aio@kvack.org>
References: <1055810609.1250.1466.camel@dell_ss5.pdx.osdl.net> <3EEE6FD9.2050908@netscape.com> <20030617085408.A1934@in.ibm.com> <1055884008.1250.1479.camel@dell_ss5.pdx.osdl.net> <3EEFAC58.905@netscape.com> <20030618001534.GJ7895@parcelfarce.linux.theplanet.co.uk> <3EEFB165.5070208@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EEFB165.5070208@netscape.com>
User-Agent: Mutt/1.4.1i
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 05:25:09PM -0700, John Myers wrote:
> No, you just declare that those errors happend "after queuing."

	But POSIX specifes that all detection that can happen before
queuing should.

> EAGAIN error handling does not require contextual information about the 
> operation being queued.  Error handling logic that knows about the 
> context of the operation queued already has to exist in the 
> io_getevents() processing.

	You also now require a poll round and aditional system call to
see the errors.  In addition, you waste resources until you pick up the
errorneous call.

Joel


-- 

Life's Little Instruction Book #237

	"Seek out the good in people."

			http://www.jlbec.org/
			jlbec@evilplan.org
