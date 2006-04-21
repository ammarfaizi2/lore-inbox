Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWDUC2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWDUC2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWDUC17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:27:59 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:61660 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750946AbWDUCZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:25:21 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:25:19 -0700
Message-Id: <20060421022519.6145.78248.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 0/6] Number of Tasks Resource controller
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Numtasks controller is a simple resource controller that provides user the
ability to
	- control the number of tasks a class can have
	- control the rate at which forks happen in the system

Patch descriptions:
1/6: ckrm_numtasks_init
	- Hooks up with CKRM core by defining the basic alloc/free
	  functions and registering the controller with the core.

2/6: ckrm_numtasks_tasksupport
	- Adds task management support by defining a function to be called
	  from fork() to see if the class is within its share allocation
	- sets interface to be called from core when a class is moved to a
	  class.

3/6: ckrm_numtasks_shares_n_stats
	- sets interface to be called from core when a class's shares are
	  changes or when stats are requested.

4/6: ckrm_numtasks_config
	- Use module parameters to dynamically set the total numtasks
		and maximum forkrate allowed

5/6: ckrm_numtasks_forkrate
	- Adds support to control the forkrate in the system.

6/6: ckrm_numtasks_docs
	- Documents what the numtasks controller does and how to use it.

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
