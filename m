Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265354AbUEZI1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUEZI1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 04:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265355AbUEZI1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 04:27:21 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:38837 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S265354AbUEZI1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 04:27:20 -0400
Date: Wed, 26 May 2004 10:27:12 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Anthony DiSante <orders@nodivisions.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Message-ID: <20040526082712.GA32326@k3.hellgate.ch>
Mail-Followup-To: Anthony DiSante <orders@nodivisions.com>,
	linux-kernel@vger.kernel.org
References: <40B43B5F.8070208@nodivisions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B43B5F.8070208@nodivisions.com>
X-Operating-System: Linux 2.6.6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 02:38:23 -0400, Anthony DiSante wrote:
> Now I buy another 256MB of ram, so I have 512MB of real memory.  Why not 
> just disable my swap completely now?  I won't have increased my memory's 
> size at all, but won't I have increased its performance lots?
> 
> Or, to make it more appealing, say I initially had 512MB ram and now I have 
> 1GB.  Wouldn't I much rather not use swap at all anymore, in this case, on 
> my desktop?

Swap serves another (often underrated) purpose: Graceful degradation.

If you have a reasonably amount of swap space mounted, you will know
you are running out of RAM because your system will become noticeably
slower. If you have no swap whatsoever, your first warning will quite
possibly be an application OOM killed or losing data due to a failed
memory allocation.

Think of the slowness of swap as a _feature_.

Roger
