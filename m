Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262269AbREVC2o>; Mon, 21 May 2001 22:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbREVC2e>; Mon, 21 May 2001 22:28:34 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:49160 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S262269AbREVC2V>;
	Mon, 21 May 2001 22:28:21 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15113.52912.856909.338939@argo.ozlabs.ibm.com>
Date: Tue, 22 May 2001 12:28:00 +1000 (EST)
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <Pine.GSO.4.21.0105211814130.12245-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.LNX.4.31.0105211503560.10331-100000@penguin.transmeta.com>
	<Pine.GSO.4.21.0105211814130.12245-100000@weyl.math.psu.edu>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:

> drivers/net/ppp_generic.c:
> ppp_set_compress(struct ppp *ppp, unsigned long arg)
> {
[snip]
>         if (copy_from_user(&data, (void *) arg, sizeof(data))
>             || (data.length <= CCP_MAX_OPTION_LENGTH
>                 && copy_from_user(ccp_option, data.ptr, data.length)))
>                 goto out;
> 
> And that's far from being uncommon. They _do_ follow pointers. Some - more
> than once.

:) That particular example is one that would probably be much cleaner
as a write on a control fd.  What is there currently is just a
relatively ugly way of getting a variable-sized lump of data from
usermode into the kernel.

Paul.
