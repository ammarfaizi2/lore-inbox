Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbTCTKv6>; Thu, 20 Mar 2003 05:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTCTKv6>; Thu, 20 Mar 2003 05:51:58 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:41155 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261374AbTCTKv5>; Thu, 20 Mar 2003 05:51:57 -0500
Date: Thu, 20 Mar 2003 11:04:48 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63)) 
In-Reply-To: <32005.1048157303@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0303201100210.1453-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Mar 2003, Keith Owens wrote:
> On Tue, 18 Mar 2003 07:13:18 +0000 (GMT), 
> Hugh Dickins <hugh@veritas.com> wrote:
> >If you go ahead with this (I'm indifferent)
> 
> ksymoops 2.4.9 can decode variable length instructions before eip
> without affecting the reliabiloity of the code from eip onwards.  It is
> up to the kernel whether it dumps before eip or not.
> 
> >please remember that to
> >get reliable code from eip onwards, you need to handle the way both
> >2.4 and 2.5 nowadays pack short __LINE__ number and long __FILE__
> >pointer after BUG()'s ud2a (on i386).
> 
> Nothing I can do about that.  ksymoops uses objdump to decode the
> instructions and objdump does not know that the kernel abuses ud2a to
> add embedded line and file numbers.  In any case it is irrelevant, the
> only thing that ud2a ever tells you is "here there be BUG()".  For
> BUG() the code before eip is much more useful, see above.

But better not to describe the code shown from eip onwards as
"always reliable": if after a BUG() it's alarming nonsense!

Hugh

