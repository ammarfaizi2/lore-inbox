Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262197AbTCRHAk>; Tue, 18 Mar 2003 02:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262198AbTCRHAk>; Tue, 18 Mar 2003 02:00:40 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:61655 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262197AbTCRHAi>; Tue, 18 Mar 2003 02:00:38 -0500
Date: Tue, 18 Mar 2003 07:13:18 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63)) 
In-Reply-To: <1306.1047958084@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0303180703260.9756-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003, Keith Owens wrote:
> 
> I can change ksymoops to add a special case for architectures with
> variable length instructions - i386, s390 and their 64 bit equivalents,
> are there any others?  For variable length instructions, ksymoops will
> extract the bytes up to but not including eip, decode and print them
> with a warning
> 
>   This architecture has variable length instructions, decoding before eip is
>   unreliable, take these instructions with a pinch of salt.
> 
> Then the code from eip onwards will be decoded as normal, with the
> heading 'This code should be reliable'.

If you go ahead with this (I'm indifferent), please remember that to
get reliable code from eip onwards, you need to handle the way both
2.4 and 2.5 nowadays pack short __LINE__ number and long __FILE__
pointer after BUG()'s ud2a (on i386).

Hugh

