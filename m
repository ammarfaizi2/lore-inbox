Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbTH2Twc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 15:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTH2Twb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 15:52:31 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:62902 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261611AbTH2Tw3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:52:29 -0400
Subject: [RFC] Class-based Kernel Resource Management
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: ckrm-tech@lists.sourceforge.net
Content-Type: text/plain
Organization: 
Message-Id: <1062186708.15245.832.camel@elinux05.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Aug 2003 15:51:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As promised at the Ottawa Linux Symposium presentation in July, here
is the first code drop for the Class-based Kernel Resource Management
project.

The Class-based Kernel Resource Management (CKRM)
project seeks to develop Linux kernel mechanisms providing
differentiated service to resources such as CPU time, memory pages,
I/O and incoming network bandwith based on user defined groups of
tasks called classes. Changes to the primary resource schedulers such
as O(1) (cpu), deadline/CFQ (I/O) , VM page manager (memory) and
inbound network connection managers will be explored and developed.

More details on the project can be found at

	http://ckrm.sf.net

including 

- the paper and presentation at the Ottawa Linux Symposium 2003
- current status
- patches, modules, user programs
- detailed description of individual components and
- results from the version that was talked about at OLS'03.


The current CKRM design consists of the following components:

1) Core patch: Kernel patch defining kernel API and hooks for the
classification module and individual resource (cpu,mem,io,net)
controllers.  

2) Classification and user API module: Loadable module implementing a
Rule-based Classification Engine (RBCE) and defining a user API to
CKRM. Requires the core patch.  


3) CPU controller: Kernel patch implementing class-based CPU
control.Requires the core patch and some classification module like
RBCE.  

4) Memory controller: Kernel patch for class-based control of physical
memory.  Requires the core patch and some classification module like
RBCE.

5) I/O controller: Design proposed in OLS. To be developed in
conjunction with Jens Axboe's next version of CFQ I/O scheduler.

6) Inbound network controller: Design proposed. In development.

The next few mail will contain the patches for 1),3) and 4), the module
for 2).


If you are interested in this project, please join the ckrm-tech mailing
list at 
	http://lists.sourceforge.net/lists/listinfo/ckrm-tech

You are also welcome to join as a developer by sending a mail to the
project admins
Hubertus Franke (frankeh@users.sf.net) and Shailabh Nagar
(nagar@users.sf.net).

CKRM has been jointly developed by a number of folks including
Hubertus Franke, Shailabh Nagar, Chandra Seetharaman, Jiantao Kong,
Haoqiang Zheng, Vivek Kashyap, Nivedita Singhvi and Jonghyuk Choi.

 

-- Shailabh


