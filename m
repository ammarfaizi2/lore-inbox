Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314344AbSDRNMI>; Thu, 18 Apr 2002 09:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314345AbSDRNMH>; Thu, 18 Apr 2002 09:12:07 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:29377 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314344AbSDRNMG>;
	Thu, 18 Apr 2002 09:12:06 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15550.50131.489249.256007@nanango.paulus.ozlabs.org>
Date: Thu, 18 Apr 2002 23:02:11 +1000 (EST)
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables
In-Reply-To: <1589.1019123186@ocs3.intra.ocs.com.au>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:

> The use of __init and __exit sections breaks the assumption that tables
> such as __ex_table are sorted, it has already broken the dbe table in
> mips on 2.5.  This patch against 2.5.8 adds a generic sort routine and
> sorts the i386 exception table.
> 
> This sorting needs to be extended to several other tables, to all
> architectures, to modutils (insmod loads some of these tables for

We already sort the kernel exception table on PPC using an insertion
sort.  We have chrp, pmac, prep sections as well as init, which is why
we had to do that.

BTW, do you have any valid examples of use of copy_to/from_user or
get/put_user in an init section?

Regards,
Paul.
