Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbTCTKhl>; Thu, 20 Mar 2003 05:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbTCTKhk>; Thu, 20 Mar 2003 05:37:40 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:36106 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261384AbTCTKhk>;
	Thu, 20 Mar 2003 05:37:40 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63)) 
In-reply-to: Your message of "Tue, 18 Mar 2003 07:13:18 -0000."
             <Pine.LNX.4.44.0303180703260.9756-100000@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 20 Mar 2003 21:48:23 +1100
Message-ID: <32005.1048157303@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003 07:13:18 +0000 (GMT), 
Hugh Dickins <hugh@veritas.com> wrote:
>If you go ahead with this (I'm indifferent)

ksymoops 2.4.9 can decode variable length instructions before eip
without affecting the reliabiloity of the code from eip onwards.  It is
up to the kernel whether it dumps before eip or not.

>please remember that to
>get reliable code from eip onwards, you need to handle the way both
>2.4 and 2.5 nowadays pack short __LINE__ number and long __FILE__
>pointer after BUG()'s ud2a (on i386).

Nothing I can do about that.  ksymoops uses objdump to decode the
instructions and objdump does not know that the kernel abuses ud2a to
add embedded line and file numbers.  In any case it is irrelevant, the
only thing that ud2a ever tells you is "here there be BUG()".  For
BUG() the code before eip is much more useful, see above.

