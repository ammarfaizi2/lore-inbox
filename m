Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVJBQqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVJBQqP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 12:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVJBQqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 12:46:15 -0400
Received: from pop.gmx.de ([213.165.64.20]:15006 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751126AbVJBQqP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 12:46:15 -0400
X-Authenticated: #9962044
From: Marc <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: clock skew on B/W G3
Date: Sun, 2 Oct 2005 18:46:09 +0200
User-Agent: KMail/1.8.2
References: <200510011429.45698.marvin24@gmx.de>
In-Reply-To: <200510011429.45698.marvin24@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510021846.09860.marvin24@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some additions to the previous mail: I was able to isolate the problem to the 
introduction of a user specificable value of HZ (in include/asm-ppc/parm.h). 
I used a value of 250 while the former default was 1000. Setting it back to 
1000 makes the clock tick right again.

Is the CONFIG_HZ known to be broken on PPC ?

Thanks

Marc

Le Samstag 01 Oktober 2005 14:29, marvin24@gmx.de a écrit :
> Hi,
>
> something between 2.6.13-git4 and 2.6.14-git5 makes my clock running ~20%
                                        ^^ should be 13 of course 

> slower. This problem still exists in current kernel versions. Sorry for
> reporting so late, but I hope it would go away while time passes...
>
> As the subject says I have blue/white Apple G3/400. My config I attached.
