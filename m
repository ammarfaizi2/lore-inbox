Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292444AbSBUPMw>; Thu, 21 Feb 2002 10:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292432AbSBUPMf>; Thu, 21 Feb 2002 10:12:35 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39873 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S292439AbSBUPMN>; Thu, 21 Feb 2002 10:12:13 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200202211512.g1LFC8Y27614@devserv.devel.redhat.com>
Subject: Re: [PATCH] kernel 2.5.5 - coredump sysctl
To: msinz@wgate.com (Michael Sinz)
Date: Thu, 21 Feb 2002 10:12:07 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, torvalds@transmeta.com,
        msinz@wgate.com
In-Reply-To: <200202211433.g1LEXP813292@sinz.eng.tvol.net> from "Michael Sinz" at Feb 21, 2002 09:33:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it be cleaner to use snprintf here ? Each of those checks you do
appears to come down to 

	buf+=snprintf(buf, sizeof(buffer)+buffer-buf, "%foo", arg)

which is how procfs tends to handle this stuff. 
