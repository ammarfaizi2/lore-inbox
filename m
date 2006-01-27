Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWA0Ukd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWA0Ukd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbWA0Ukd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:40:33 -0500
Received: from host233.omnispring.com ([69.44.168.233]:20664 "EHLO
	iradimed.com") by vger.kernel.org with ESMTP id S1161014AbWA0Ukd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:40:33 -0500
Message-ID: <43DA851D.6070209@cfl.rr.com>
Date: Fri, 27 Jan 2006 15:39:57 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: jmerkey@ns1.utah-nac.org
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14 kernels and above copy_to_user stupidity with IRQ disabled
 check
References: <43DA62CC.8090309@wolfmountaingroup.com> <Pine.LNX.4.61.0601271513360.15124@chaos.analogic.com> <20060127201058.GA18805@ns1.utah-nac.org>
In-Reply-To: <20060127201058.GA18805@ns1.utah-nac.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2006 20:40:58.0805 (UTC) FILETIME=[FA8EBE50:01C62381]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14232.000
X-TM-AS-Result: No--1.000000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey@ns1.utah-nac.org wrote:
> OK.  Got it.  I guess I need to restructure.  And BTW, This was a code fragment
> only, the spinlock gets released when -EFAULT is called -- was just an example.
>
> Jeff

Unless you have redefined EFAULT in some strange and hideous way, it is 
not "called" and doesn't free the spinlock.  EFAULT is defined as a 
literal integer, so you're just returning a number without freeing the 
spinlock. 


If you have redefined EFAULT to a macro function call or whatever, then 
don't do that, it's REALLY horrible coding practice. 


