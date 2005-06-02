Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVFBA3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVFBA3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 20:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVFBA0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 20:26:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41717 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261547AbVFBA0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 20:26:11 -0400
Subject: RE: [PATCH] Abstracted Priority Inheritance for RT
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com, rostedt@goodmis.org
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A03667149@orsmsx407>
References: <F989B1573A3A644BAB3920FBECA4D25A03667149@orsmsx407>
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 01 Jun 2005 17:25:53 -0700
Message-Id: <1117671953.7646.14.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 17:10 -0700, Perez-Gonzalez, Inaky wrote:

> Maybe he is referring to the case?
> 
> A owns M
> B owns N and is waiting for M
> A is trying to wait for N
> 
> These deadlocking cases can be tricky during PI.


The bulk of the code is from the current RT mutex, so I'm assuming it
handles this case correctly. However, the rt mutex isn't in userspace ,
so task A or B was a user space task , then the problem would need to be
explored.. How does PI change if A or B are user space tasks?

Daniel

