Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWD1Bmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWD1Bmq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWD1Bfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:35:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:39346 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030245AbWD1BfU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:35:20 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:35:18 -0700
Message-Id: <20060428013518.27212.954.sendpatchset@localhost.localdomain>
Subject: [PATCH 0/6] Number of Tasks Resource controller
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Numtasks controller is a simple resource controller that provides user the
ability to
	- control the number of tasks a class can have
	- control the rate at which forks happen in the system

on top of Resource Groups.

Please consider these for inclusion in -mm tree.
--
Patch descriptions:

1/6: numtasks_init

Hooks up with Resource Groups core by defining the basic alloc/free
functions and registering the controller with the core.

2/6: numtasks_tasksupport

Adds task management support by defining a function to be called from
fork() to see if the resource group is within its share allocation
Sets interface to be called from core when a task is moved to a resource
group.

3/6: numtasks_shares_n_stats

Sets interface to be called from core when a resource group's shares are
changes or when stats are requested.

4/6: numtasks_config

Use module parameters to dynamically set the total numtasks and maximum
forkrate allowed.

5/6: numtasks_forkrate

Adds support to control the forkrate in the system. 

6/6: numtasks_docs

Documents what the numtasks controller does and how to use it. 

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
