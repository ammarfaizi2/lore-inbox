Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVC3SPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVC3SPC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVC3SNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:13:22 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:38586 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262378AbVC3SMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:12:55 -0500
Message-ID: <424AEBE3.1010100@engr.sgi.com>
Date: Wed, 30 Mar 2005 10:11:47 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>
CC: Paul Jackson <pj@engr.sgi.com>, johnpol@2ka.mipt.ru,
       guillaume.thouvenin@bull.net, akpm@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr> <20050328134242.4c6f7583.pj@engr.sgi.com> <1112079856.5243.24.camel@uganda> <20050329004915.27cd0edf.pj@engr.sgi.com> <1112092197.5243.80.camel@uganda> <20050329090304.23fbb340.pj@engr.sgi.com> <4249C418.5040007@engr.sgi.com> <Pine.LNX.4.62.0503292200550.30657@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.62.0503292200550.30657@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parent information ((ppid,pid) pair) is useful for process group
aggregation while do_exit() hook is needed to save per task
accounting data before the task data is disposed.

Thanks,
  - jay


dean gaudet wrote:
> On Tue, 29 Mar 2005, Jay Lan wrote:
> 
> 
>>The fork_connector is not designed to solve accounting data collection
>>problem.
>>
>>The accounting data collection must be done via a hook from do_exit().
> 
> 
> by the time do_exit() occurs the parent may have disappeared... you do 
> need to record something at fork() time so that you can account to the 
> correct ancestor.
> 
> an example of where this ancestry is useful would be the summation of all 
> cpu time spent by children of apache, spamd, clamd, ...
> 
> -dean

