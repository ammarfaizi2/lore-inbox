Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319462AbSH2X6e>; Thu, 29 Aug 2002 19:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319463AbSH2X6e>; Thu, 29 Aug 2002 19:58:34 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:36485 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S319462AbSH2X6c>; Thu, 29 Aug 2002 19:58:32 -0400
Date: Fri, 30 Aug 2002 01:02:50 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: cfraas <chris@weh.rwth-aachen.de>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: PROBLEM: found kernelbug about ext3 filesystem journaling
Message-ID: <20020830010250.E23868@redhat.com>
References: <3D6D2971.4030509@weh.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D6D2971.4030509@weh.rwth-aachen.de>; from chris@weh.rwth-aachen.de on Wed, Aug 28, 2002 at 09:50:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 28, 2002 at 09:50:09PM +0200, cfraas wrote:

> Aug 28 20:57:17 chris kernel: Assertion failure in 
> journal_unmap_buffer() at transaction.c:1859: "transaction == 
> journal->j_running_transaction"

There have been a couple of bugs fixed in ext3 that _might_ relate to
that, but no recent ones I can think of which are definitely
associated with that sort of sympton.  

> kernel version from /proc/version:
> Linux version 2.4.18-6mdk (quintela@bi.mandrakesoft.com) (gcc version 
> 2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #1 Fri Mar 15 02:59:08
> CET 2002

I'm not sure just what version of the code Mandrake are shipping,
though.  The latest ext3 is almost completely merged into Marcelo's bk
tree now --- can you reproduce with that code?

Without ksymoops output for the oops, there's not much else I can do
with this.

--Stephen
