Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVE0ADm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVE0ADm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 20:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVE0ADm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 20:03:42 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:40640 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261862AbVE0ADc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 20:03:32 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Roland McGrath <roland@redhat.com>
Subject: Re: waitid() fails with EINVAL for SA_RESTART signals
Date: Thu, 26 May 2005 20:03:28 -0400
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       mtk-lkml@gmx.net, linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
References: <200505262322.j4QNMnd9011168@magilla.sf.frob.com>
In-Reply-To: <200505262322.j4QNMnd9011168@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505262003.29228.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 May 2005 19:22, Roland McGrath wrote:
> > x86 has largely tried to move in that direction too, ie a lot of the
> > asm-calls have been turned into FASTCALL() with %eax pointing to the
> > stack.
> >
> > Roland, I applied the patch, but if there was some particular case that
> > triggered this, maybe it's worth trying to re-write that one.
>
> It's a danger for any system call.  Here it was sys_waitid.

On X86_64 the given program fails with Operation Not Supported error on 
waitid() - both 32bit and 64bit modes. The problem seems to be WCONTINUED - 
is it unimplemented on X86_64?
