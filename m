Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968825AbWLGJ0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968825AbWLGJ0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968826AbWLGJ0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:26:50 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:51866 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968825AbWLGJ0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:26:49 -0500
Message-ID: <4577DE46.5000603@ens-lyon.org>
Date: Thu, 07 Dec 2006 10:26:30 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: paulmck@linux.vnet.ibm.com
CC: "Paul E. McKenney" <paulmck@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: sparse errors in srcu.h
References: <45769256.1070400@ens-lyon.org> <20061206161537.GA2013@linux.vnet.ibm.com>
In-Reply-To: <20061206161537.GA2013@linux.vnet.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
> On Wed, Dec 06, 2006 at 10:50:14AM +0100, Brice Goglin wrote:
>   
>> Hi,
>>
>> When running sparse checks on a file that ends up including srcu.h, we
>> get the following warnings:
>>
>>     include/linux/srcu.h:52:44: error: undefined identifier 'sp'
>>     include/linux/srcu.h:52:44: error: bad constant expression
>>     include/linux/srcu.h:53:56: error: undefined identifier 'sp'
>>     include/linux/srcu.h:53:56: error: bad constant expression
>>
>> It seems to be caused by the following lines:
>>
>>     int srcu_read_lock(struct srcu_struct *sp) __acquires(sp);
>>     void srcu_read_unlock(struct srcu_struct *sp, int idx) __releases(sp);
>>
>> which come from the following commit.
>>
>>     commit 621934ee7ed5b073c7fd638b347e632c53572761
>>     Author: Paul E. McKenney <paulmck@us.ibm.com>
>>     Date:   Wed Oct 4 02:17:02 2006 -0700
>>
>>     [PATCH] srcu-3: RCU variant permitting read-side blocking
>>
>>
>> I was wondering if there is a way to fix those errors...
>>     
>
> I believe that you need to update your version of sparse to 0.1.
> See http://lwn.net/Articles/208312/ for more info.
>
> 							Thanx, Paul
>   

Right, thanks, I had an old version hidden in /usr/local, works fine now.

Brice

