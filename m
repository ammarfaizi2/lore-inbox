Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbULBLag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbULBLag (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 06:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbULBLag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 06:30:36 -0500
Received: from tri-e2k.ethz.ch ([129.132.112.23]:16975 "EHLO tri-e2k.ethz.ch")
	by vger.kernel.org with ESMTP id S261590AbULBLa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 06:30:29 -0500
Message-ID: <41AEFCCC.10907@dbservice.com>
Date: Thu, 02 Dec 2004 12:30:20 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <E1CZiZZ-0005ew-00@calista.eckenfels.6bone.ka-ip.net> <41AEA3F0.9080100@bigpond.net.au>
In-Reply-To: <41AEA3F0.9080100@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Dec 2004 11:30:27.0799 (UTC) FILETIME=[52A27670:01C4D862]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Design by contract isn't really an agreement between the caller and the 
> callee (which may not even exist when the contract is created).  It's 
> more of a (one way) promise by the callee that if the interface is used 
> as described in the contract that it will correctly perform the 
> advertised operation (where the advertised operation generally includes 
> descriptions of possible failures and how they will be signalled).  Most 
> C APIs meet these criteria even though their pre and post conditions are 
> expressed less formally than an Eiffel interface.

Design by Contract, as seen in the Eiffel language, is not a one way 
promise, it's a contract between the caller and callee. Both sides have
to fullfil their part of the contract, the caller has to make sure that
the input are valid, and (only) given that, the callee can/has to make
sure that the caller gets the right output.

BTW, Bertrand Meyer is one of my professors, I should know the Eiffel 
language... :)

> I agree but think it's important to realize that it's a unilateral 
> promise on the part of the callee (rather than agreement between the 
> callee and the caller) which is in accord with Linus's view of the ABI.

Whenever you have two sides/parties, you have to agree on _something_, 
otherwise you can't communicate, if you speak to someone, you have to 
choose a language in which to speak, that's the first agreement.
In this situation you have two sides, the kernel and the userspace. Your 
first agreement is the syscall number, and then the arguments, the type 
and format of the arguments, etc. Both sides have to agree on those things.

tom


