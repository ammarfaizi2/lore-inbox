Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293552AbSCGPXf>; Thu, 7 Mar 2002 10:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310359AbSCGPXZ>; Thu, 7 Mar 2002 10:23:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:64182 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293552AbSCGPXG>; Thu, 7 Mar 2002 10:23:06 -0500
Date: Thu, 07 Mar 2002 09:21:28 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: frankeh@watson.ibm.com, Rusty Russell <rusty@rustcorp.com.au>,
        rajancr@us.ibm.com
cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
Message-ID: <8130000.1015514488@baldur.austin.ibm.com>
In-Reply-To: <20020307143404.A8FFF3FE06@smtp.linux.ibm.com>
In-Reply-To: <20020305145004.BFA503FE06@smtp.linux.ibm.com>
 <20020307145630.7d4aed95.rusty@rustcorp.com.au>
 <20020307143404.A8FFF3FE06@smtp.linux.ibm.com>
X-Mailer: Mulberry/2.2.0b2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, March 07, 2002 09:35:09 AM -0500 Hubertus Franke
<frankeh@watson.ibm.com> wrote:

>> At a cursory glance, this seems to be three patches:
>> 	1) Fix the get_pid() hang.
>> 	2) Speed up get_pid().
>> 
>> 	3) And this piece I'm not sure about:
>> > +                 if(p->tgid > last_pid && next_safe > p->tgid)
>> > +                       next_safe = p->tgid;

> 1) was done by Greg Larson and was already submitted
> 2) once properly done, we will circulate before bothering Linus again
> 3) this must have come in because of a wrong patch generation.

Actually that was Paul Larson, but close enough :)

3) is actually a separate bugfix.  I had a patch accepted some time back
that added the check for tgid, but missed adding it to the section below.
Paul caught it when he did his patch and added it for me.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

