Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVDLSfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVDLSfO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVDLSeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:34:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37875 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262339AbVDLR42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 13:56:28 -0400
Subject: Re: [PATCH] Priority Lists for the RT mutex
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       linux-kernel@vger.kernel.org, inaky.perez-gonzalez@intel.com,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Joe Korty <joe.korty@ccur.com>
In-Reply-To: <20050410110945.GA7871@elte.hu>
References: <1112896344.16901.26.camel@dhcp153.mvista.com>
	 <20050408062811.GA19204@elte.hu>
	 <1112947503.7093.28.camel@sdietrich-xp.vilm.net>
	 <20050410110945.GA7871@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1113328576.23407.128.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Apr 2005 10:56:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-10 at 04:09, Ingo Molnar wrote:
> Unless i'm missing something, this could be implemented by detaching
> lock->owner_prio from lock->owner - via e.g. negative values. Thus some
> minimal code would check whether we need the owner's priority in the PI
> logic, or the semaphore's "own" priority level.

The owners priority should be set to the semaphore's priority .. Or the
highest priority of all the semaphores that it has locked.

Daniel

