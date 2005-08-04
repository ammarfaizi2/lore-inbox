Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVHDL1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVHDL1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 07:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVHDL1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 07:27:20 -0400
Received: from tim.rpsys.net ([194.106.48.114]:48826 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262472AbVHDL1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 07:27:18 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Richard Purdie <rpurdie@rpsys.net>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
In-Reply-To: <Pine.LNX.4.62.0508031716001.24733@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	 <1122860603.7626.32.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508010908530.3546@graphe.net>
	 <1122926537.7648.105.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011335090.7011@graphe.net>
	 <1122930474.7648.119.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011414480.7574@graphe.net>
	 <1122931637.7648.125.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011438010.7888@graphe.net>
	 <1122933133.7648.141.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011517300.8498@graphe.net>
	 <1122937261.7648.151.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508031716001.24733@graphe.net>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 12:27:05 +0100
Message-Id: <1123154825.8987.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 17:19 -0700, Christoph Lameter wrote:
> Could you try the following patch? I think the problem was that higher 
> addressses were not mappable via the page fault handler. This patch 
> inserts the pmd entry into the pgd as necessary if the pud level is 
> folded.

I tried this patch against 2.6.13-rc4-mm1 and there was no change - X
still hung in memcpy as before and the cmpxchg_fail_flag_update just
increases...

Richard

