Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbTDCSyZ 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 13:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263436AbTDCSvT 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 13:51:19 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:6798 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S263434AbTDCSvA 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 13:51:00 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 3 Apr 2003 11:00:02 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rik van Riel <riel@surriel.com>
cc: Pete Zaitcev <zaitcev@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "" <linux390@de.ibm.com>
Subject: Re: gcc-3.2 breaks rmap on s390x
In-Reply-To: <Pine.LNX.4.44.0304031339350.11467-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.50.0304031056340.1827-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0304031339350.11467-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003, Rik van Riel wrote:

> On Thu, 3 Apr 2003, Pete Zaitcev wrote:
>
> >  			cpu_relax();
> > +			barrier();
>
> Gah, now I look over the source I see that cpu_relax() is always
> used together with barrier() ...
>
> I guess the best long-term thing (2.5) would be to build a barrier
> into cpu_relax(), but for 2.4-rmap I'll just add your patch.

cpu_relax() is a barrier on Intel ( pause ). It's just a coincidence IMHO.



- Davide

