Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263855AbUCZAcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUCZAcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:32:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18645 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263855AbUCZANw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:13:52 -0500
Message-ID: <406375B0.5040406@pobox.com>
Date: Thu, 25 Mar 2004 19:13:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
References: <760890000.1079727553@aslan.btc.adaptec.com> <16480.61927.863086.637055@notabene.cse.unsw.edu.au> <40624235.30108@pobox.com> <200403251200.35199.kevcorry@us.ibm.com> <40632804.1020101@pobox.com> <1030470000.1080257746@aslan.btc.adaptec.com>
In-Reply-To: <1030470000.1080257746@aslan.btc.adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs wrote:
>>I respectfully disagree with the EMD folks that a userland approach is
>>impossible, given all the failure scenarios.
> 
> 
> I've never said that it was impossible, just unwise.  I believe
> that a userland approach offers no benefit over allowing the kernel
> to perform all meta-data operations.  The end result of such an
> approach (given feature and robustness parity with the EMD solution)
> is a larger resident side, code duplication, and more complicated
> configuration/management interfaces.

There is some code duplication, yes.  But the right userspace solution 
does not have a larger RSS, and has _less_ complicated management 
interfaces.  A key benefit of "do it in userland" is a clear gain in 
flexibility, simplicity, and debuggability (if that's a word).

But it's hard.  It requires some deep thinking.  It's a whole lot easier 
to do everything in the kernel -- but that doesn't offer you the 
protections of userland, particularly separate address spaces from the 
kernel, and having to try harder to crash the kernel.  :)

	Jeff



