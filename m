Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289872AbSAPGBQ>; Wed, 16 Jan 2002 01:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290363AbSAPGBG>; Wed, 16 Jan 2002 01:01:06 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:33037 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S289872AbSAPGAt>;
	Wed, 16 Jan 2002 01:00:49 -0500
Date: Wed, 16 Jan 2002 17:00:14 +1100
From: Anton Blanchard <anton@samba.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: likely/unlikely
Message-ID: <20020116060014.GB24266@krispykreme>
In-Reply-To: <3C450C4A.8A8382A6@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C450C4A.8A8382A6@mandrakesoft.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> likely/unlikely set the branch prediction values to 99% or 1%
> respectively.  If this causes the code generated to perform less
> optimally than without, I'm sure the gcc guys would be -very- interested
> to hear that...

On some ppc64 the branch prediction is quite good and static prediction
will override the dynamic prediction. I think we avoid predicting a
branch unless we are quite sure (95%/5%).

So if likely/unlikely is overused (on more marginal conditionals) then
it could be a performance loss.

Anton
