Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290592AbSCEWGN>; Tue, 5 Mar 2002 17:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288377AbSCEWFx>; Tue, 5 Mar 2002 17:05:53 -0500
Received: from hermes.toad.net ([162.33.130.251]:11470 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S287421AbSCEWFp>;
	Tue, 5 Mar 2002 17:05:45 -0500
Subject: Re: init_idle reaped before final call
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 05 Mar 2002 17:06:43 -0500
Message-Id: <1015366005.1157.776.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you're right.  To prevent the mistake from
happening again, I'd suggest you add a comment to your
patch for init_idle(), explaining that it can't be __init 
because it is called by cpu_idle, which is called
by rest_init(), which ...

I wonder if an automated __init consistency checker 
would be helpful.

--
Thomas Hood


