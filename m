Return-Path: <linux-kernel-owner+w=401wt.eu-S965147AbXAKBFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbXAKBFQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 20:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbXAKBFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 20:05:16 -0500
Received: from secure.tummy.com ([66.35.36.132]:34125 "EHLO secure.tummy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965147AbXAKBFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 20:05:15 -0500
Date: Wed, 10 Jan 2007 18:04:29 -0700
From: Sean Reifschneider <jafo@tummy.com>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: select() setting ERESTARTNOHAND (514).
Message-ID: <20070111010429.GN7121@tummy.com>
References: <20070110234238.GB10791@tummy.com> <20070110.162747.28789587.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070110.162747.28789587.davem@davemloft.net>
User-Agent: Mutt/1.4.2.2i
X-Hashcash: 1:26:070111:linux-kernel@vger.kernel.org::moMpddCqmQuawCt7:000000000
	000000000000000000000001IBVD
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 04:27:47PM -0800, David Miller wrote:
>It gets caught by the return into userspace code.

Ok, so somehow it is leaking.  I have a system in the lab that is the same
hardware as production, but it currently has no, you know, hard drives in
it, so some assembly is required.  I'll see if I can reproduce it in a test
environment and then see if I can get more information on when/where it is
leaking.

>Note that select() only returns these values when signal_pending()
>is true.

Yes, I saw that.  I didn't fully understand it, but I saw it.

Thanks,
Sean
-- 
 CChheecckk yyoouurr dduupplleexx sswwiittcchh..
Sean Reifschneider, Member of Technical Staff <jafo@tummy.com>
tummy.com, ltd. - Linux Consulting since 1995: Ask me about High Availability
      Back off man. I'm a scientist.   http://HackingSociety.org/

