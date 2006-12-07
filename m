Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031890AbWLGJey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031890AbWLGJey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031892AbWLGJey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:34:54 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:43213 "EHLO
	myri.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1031890AbWLGJex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:34:53 -0500
Message-ID: <4577E028.1040305@ens-lyon.org>
Date: Thu, 07 Dec 2006 10:34:32 +0100
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

