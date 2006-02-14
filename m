Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWBNDZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWBNDZd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 22:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWBNDZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 22:25:33 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:61292 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750783AbWBNDZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 22:25:33 -0500
Message-ID: <43F14DAA.6000703@bigpond.net.au>
Date: Tue, 14 Feb 2006 14:25:30 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: quilt-dev@nongnu.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Quilt-dev] Quilt 0.43 has been released! [SERIOUS BUG]
References: <20060202230210.05a6ad4a.khali@linux-fr.org>
In-Reply-To: <20060202230210.05a6ad4a.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 14 Feb 2006 03:25:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 
> Quilt 0.43 is now available for download from Savannah:
> http://download.savannah.gnu.org/releases/quilt/
> 
> Enjoy!
> 

I've experienced a serious problem with this version of quilt that is 
rather hard to explain but definitely arrived with this version as 
reverting to 0.42 makes the problem go away.

Now to try to explain the problem :-(

The problem arises when pushing a patch that has errors in it (due to 
changes in the previous patches in the series) and needs the -f flag to 
force the push.  What's happening is that the reverse of the errors is 
being applied to the "pre patch" file in the .pc directory.  Then when 
you pop this patch it returns the file to a state with the reverse of 
the errors applied to it.

I'm having trouble understanding how quilt could be dumb enough to do 
this as surely the "pre patch" file in the .pc directory should be just 
a copy of the file before the patch is applied.

This bug can completely hose a set of patches if the user doesn't notice 
it very early and do something about it.  The work around is to revert 
to version 0.42 of quilt.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
