Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVDAAPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVDAAPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 19:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVDAANa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 19:13:30 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:45229 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262543AbVDAAMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 19:12:21 -0500
Message-ID: <424C9177.1070404@engr.sgi.com>
Date: Thu, 31 Mar 2005 16:10:31 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net,
       aquynh@gmail.com, dean-list-linux-kernel@arctic.org, pj@sgi.com
Subject: Re: [patch 2.6.12-rc1-mm4] fork_connector: add a fork connector
References: <1112277542.20919.215.camel@frecb000711.frec.bull.fr> <20050331144428.7bbb4b32.akpm@osdl.org>
In-Reply-To: <20050331144428.7bbb4b32.akpm@osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
>  
>
>>  This patch adds a fork connector in the do_fork() routine.
>>...
>>
>>  The fork connector is used by the Enhanced Linux System Accounting
>>project http://elsa.sourceforge.net
>>    
>>
>
>Does it also meet all the in-kernel requirements for other accounting
>projects?
>
>If not, what else do those other projects need?
>  
>
Hi Andrew,

As the discussion in this thread of the past few days showed, this
patch intends to take care of process grouping, but not the
accounting data collection. Besides my concern of possibility of
data loss, this patch also provides CSA information to handle process
grouping as it intends to do. I plan to run some testing to see percentage
of data loss when system is under stress test, but improvement at
CBUS as Evgeniy indicated should help!

Please be advised that i still need an do_exit handling to save accounting
data. But, it is a separate issue.

Thanks,
 - jay

