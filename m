Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268322AbTCFTxe>; Thu, 6 Mar 2003 14:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268324AbTCFTxe>; Thu, 6 Mar 2003 14:53:34 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53159
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268322AbTCFTxd>; Thu, 6 Mar 2003 14:53:33 -0500
Subject: Re: HT and idle = poll
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <b487l2$1tn$1@penguin.transmeta.com>
References: <200303052318.04647.habanero@us.ibm.com>
	 <b487l2$1tn$1@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046984969.17718.118.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 06 Mar 2003 21:09:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 19:30, Linus Torvalds wrote:
> >So, don't use idle=poll with HT when you know your workload has idle time!  I 
> >have not tried oprofile, but it stands to reason that this would be a 

idle=poll probably needs to be doing "rep nop" in a tight loop. That
ironically also saves more power than "hlt" on PIV last time someone
investigated


