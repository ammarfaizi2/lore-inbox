Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271566AbRHPMza>; Thu, 16 Aug 2001 08:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271575AbRHPMzU>; Thu, 16 Aug 2001 08:55:20 -0400
Received: from trained-monkey.org ([209.217.122.11]:13321 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S271566AbRHPMzL>; Thu, 16 Aug 2001 08:55:11 -0400
From: Jes Sorensen <jes@trained-monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15227.49850.404277.718903@trained-monkey.org>
Date: Thu, 16 Aug 2001 08:55:22 -0400
To: root@chaos.analogic.com
Cc: ServeRAID For Linux <ipslinux@us.ibm.com>, alan@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] ips.c spin lock 64 bit issues
In-Reply-To: <Pine.LNX.3.95.1010816084145.8161A-100000@chaos.analogic.com>
In-Reply-To: <OFB6726B6C.6282CC76-ON85256AAA.00434E7F@raleigh.ibm.com>
	<Pine.LNX.3.95.1010816084145.8161A-100000@chaos.analogic.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Richard" == Richard B Johnson <root@chaos.analogic.com> writes:

Richard> I don't think that "unsigned long" is the correct data type.

Richard> Isn't there a data type that means "the largest unsigned
Richard> integer type that fits into a register on the target..."? I was
Richard> told that that's what "size_t" means. If so, all the flags
Richard> variables <everywhere> should be changed to this type. If not,
Richard> then somebody should define a "flags_t" type. With the new
Richard> 64-bit machines, this is going to bite over and over again
Richard> until something like this is done.

Face it, unsigned long *is* the correct data type. The API has been
specified like this for years, no reason to change it. long us
guaranteed to be able to hold a pointer on Linux, ie. the largest
natural data type.

And no, you are more likely to find a 32 bit size_t on some systems and
we do not need yet another obscure data type flags_t when unsigned long
does the job fine as it is.

Jes
