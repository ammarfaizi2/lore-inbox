Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbRFLXFQ>; Tue, 12 Jun 2001 19:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263761AbRFLXFG>; Tue, 12 Jun 2001 19:05:06 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:22771 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S263760AbRFLXEw>;
	Tue, 12 Jun 2001 19:04:52 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Daniel Stone <daniel@kabuki.sfarc.net>
cc: Daniel Podlejski <underley@underley.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: XFS and Alan kernel tree 
In-Reply-To: Your message of "Wed, 13 Jun 2001 08:25:52 +1000."
             <20010613082551.A3032@kabuki.openfridge.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Jun 2001 09:03:16 +1000
Message-ID: <13436.992386996@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001 08:25:52 +1000, 
Daniel Stone <daniel@kabuki.sfarc.net> wrote:
>On Sat, May 05, 2001 at 11:08:16PM +0200, Daniel Podlejski wrote:
>> I merge XFS witch Alan tree (2.4.4-ac5). It's seems to be stable.
>> Patch against Alan tree is avaliable at:
>
>Hi Daniel,
>I've got a KDB patch against a relatively recent 2.4.5-ac6, but are you
>still continuing your porting effort to the -ac series?

kdb v1.8-2.4.5-ac6 works for -ac6 through -ac13.  None of the changes
in that series affect kdb.

There have been some significant changes to page I/O handling in
2.4.6-pre[12] which are reflected in the XFS CVS tree.  -ac13 is still
using the old page_launder() code which is not as clean.  In addition
kdb for Linus's and AC's trees has diverged quite a bit because of the
console and NMI cleanup in -ac.  Fitting XFS from CVS into -ac13 will
be very nasty, you might want to wait until AC syncs to Linus's kernel
or Linus takes some of the -ac changes.

