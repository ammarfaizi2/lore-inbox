Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVC2Soc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVC2Soc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 13:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVC2Soc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 13:44:32 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:11711 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261285AbVC2So2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 13:44:28 -0500
Message-ID: <4249A206.4010506@engr.sgi.com>
Date: Tue, 29 Mar 2005 10:44:22 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@engr.sgi.com>
CC: Guillaume Thouvenin <guillaume.thouvenin@bull.net>, johnpol@2ka.mipt.ru,
       akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       efocht@hpce.nec.com, linuxram@us.ibm.com, gh@us.ibm.com,
       elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>	<20050328134242.4c6f7583.pj@engr.sgi.com>	<1112079856.5243.24.camel@uganda>	<20050329004915.27cd0edf.pj@engr.sgi.com>	<1112087822.8426.46.camel@frecb000711.frec.bull.fr> <20050329072335.52b06462.pj@engr.sgi.com>
In-Reply-To: <20050329072335.52b06462.pj@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Guillaume wrote:
> 
>>  The goal of the fork connector is to inform a user space application
>>that a fork occurs in the kernel. This information (cpu ID, parent PID
>>and child PID) can be used by several user space applications. It's not
>>only for accounting. Accounting and fork_connector are two different
>>things and thus, fork_connector doesn't do the merge of any kinds of
>>data (and it will never do). 
> 
> 
> Yes - it is clear that the fork_connector does this - inform user space
> of fork information <cpu, parent, child>.  I'm not saying that
> fork_connector should merge data; I'm observing that it doesn't, and
> that this would seem to serve the needs of accounting poorly.

Paul,

You probably can look at it this way: the accounting data being
written out by BSD are per process data and the fork connector
provides information needed to group processes into process
aggregates.

Thanks,
  - jay

> 
> Out of curiosity, what are these 'several user space applications?'  The
> only one I know of is this extension to bsd accounting to include
> capturing parent and child pid at fork.  Probably you've mentioned some
> other uses of fork_connector before here, but I missed it.
> 
> 
>>The relayfs is done, like Evgeniy said, for large amount of
>>datas. So I think that it's not suitable for what we want to achieve
>>with the fork connector.
> 
> 
> I never claimed that relayfs was appropriate for fork_connector.
> 
> I'm not trying to tape a rock to Evgeniy's screwdriver.  I'm saying that
> accounting looks like a nail to me, so let us see what rocks and hammers
> we have in our tool box.
> 

