Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313196AbSDLBPb>; Thu, 11 Apr 2002 21:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313300AbSDLBPa>; Thu, 11 Apr 2002 21:15:30 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:21744 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S313196AbSDLBP3>; Thu, 11 Apr 2002 21:15:29 -0400
Date: Thu, 11 Apr 2002 18:15:24 -0700
From: Chris Wright <chris@wirex.com>
To: xystrus <xystrus@haxm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: link() security
Message-ID: <20020411181524.A1463@figure1.int.wirex.com>
Mail-Followup-To: xystrus <xystrus@haxm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020411192122.F5777@pizzashack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* xystrus (xystrus@haxm.com) wrote:
> 
> Is there a good reason why a user can successfully link() a file to
> which they do not have any access?

Other than the fact that it's standard behaviour?  ;-) Well, the SUS
actually makes an allowance for this:

	"The implementation may require that the calling process has
	permission to access the existing file."

If you are interested, the Openwall patch does just this (among other things)
http://openwall.com.  Work based on Solar Designer's Openwall patch has
been brought forward to more recent 2.4 and 2.5 kernels.  Both the
following projects implement the Openwall secure link feature:

  http://grsecurity.net
  http://lsm.immunix.org

This can break some applications that make assumptions wrt. link(2)
(Courier MTA for example).

cheers,
-chris
