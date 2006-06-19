Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWFSTDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWFSTDp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWFSTDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:03:45 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:7565 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964857AbWFSTDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:03:44 -0400
Subject: Resource Management Requirements (was "[RFC] CPU controllers?")
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, sam@vilain.net, vatsa@in.ibm.com,
       dev@openvz.org, efault@gmx.de, mingo@elte.hu, pwil3058@bigpond.net.au,
       balbir@in.ibm.com, linux-kernel@vger.kernel.org,
       maeda.naoaki@jp.fujitsu.com, kurosawa@valinux.co.jp,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <4495009D.9030505@yahoo.com.au>
References: <20060615134632.GA22033@in.ibm.com>
	 <4493C1D1.4020801@yahoo.com.au>	<20060617164812.GB4643@in.ibm.com>
	 <4494DF50.2070509@yahoo.com.au>	<4494EA66.8030305@vilain.net>
	 <4494EE86.7090209@yahoo.com.au> <20060617234259.dc34a20c.akpm@osdl.org>
	 <4495009D.9030505@yahoo.com.au>
Content-Type: text/plain
Organization: IBM
Date: Mon, 19 Jun 2006 12:03:23 -0700
Message-Id: <1150743803.30013.37.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-18 at 17:28 +1000, Nick Piggin wrote:

> OK... let me put it more clearly. What are the requirements?
Nick,

Here are some requirements we(Resource Groups aka CKRM) are working
towards (Note that this is not limited to CPU alone):

In a enterprise environment:
 - Ability to group applications into their importance levels and assign
   appropriate amount of resources to them.
 - In case of server consolidation, ability to allocate and control
   resources to a specific group of applications. Ability to 
   account/charge according to their usages.
 - manage multiple departments in a single OS instance with ability to
   allocate and control resources department wise (similar to above
   requirement :)
 - ability to guarantee "time to complete" for a specific user
   request (by controlling resource usage starting from the web server
   to the database server).
 - In case of ISPs and ASPs, ability to guarantee/limit usages to 
   independent clients (in a single OS instance). 
 - Ability to control runaway processes from bringing down the system 
   response (DoS attacks, fork bombs etc.,)
  
In a university environment (can be treated as a subset of enterprise
requirements above):
 - Ability to limit resource consumption at individual user level.
 - Ability to control runaway processes.
 - Ability for a user to manage resources allocated to them (as 
   explained in the desktop environment below). 

In a desktop environment:
 - Ability to control resource usage of a set of applications 
   (ex: infamous updatedb issue).
 - Ability to run different loads and get the expected result (like 
   checking emails or browsing Internet while compilation is in 
   progress) 

Generic:
Provide these resource management capabilities with less overhead on
overall system performance.

regards,

chandra
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


