Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVAXShd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVAXShd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVAXShd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:37:33 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:31708 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261561AbVAXSh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:37:27 -0500
Message-Id: <200501241837.j0OIbAE7011717@ginger.cmf.nrl.navy.mil>
To: Lukasz Trabinski <lukasz@oceanic.wsisiz.edu.pl>
cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Subject: Re: [Linux-ATM-General] Kernel 2.6.10 and 2.4.29 Oops fore200e (fwd) 
In-Reply-To: Message from Lukasz Trabinski <lukasz@oceanic.wsisiz.edu.pl> 
   of "Fri, 21 Jan 2005 08:46:20 +0100." <Pine.LNX.4.61L.0501210835270.6993@lt.wsisiz.edu.pl> 
Date: Mon, 24 Jan 2005 13:37:10 -0500
From: "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.61L.0501210835270.6993@lt.wsisiz.edu.pl>,Lukasz Trabinsk
i writes:
>Sorry, but I don;t understand, what line, i am not kernel guru. :/

look for the following code:

           /* retry once again? */
            if(--retry > 0) {
                schedule();
                goto retry_here;
            }


change schedule() to udelay(50) and see if things are 'better'.

>Is was happened on 2.4.29, too. It is a interrupt problem?

its calling a routine that might sleep while in the transmit routine.
this is not allow.
