Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284669AbRLIXV3>; Sun, 9 Dec 2001 18:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284650AbRLIXVV>; Sun, 9 Dec 2001 18:21:21 -0500
Received: from zero.tech9.net ([209.61.188.187]:33030 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284659AbRLIXVF>;
	Sun, 9 Dec 2001 18:21:05 -0500
Subject: Re: [PATCH] Make highly niced processes run only when idle
From: Robert Love <rml@tech9.net>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Anthony DeRobertis <asd@suespammers.org>, root <r6144@263.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011209181643.A8846@redhat.com>
In-Reply-To: <75F30A52-ECF4-11D5-80FE-00039355CFA6@suespammers.org>
	<1007939114.878.1.camel@phantasy>  <20011209181643.A8846@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 09 Dec 2001 18:21:05 -0500
Message-Id: <1007940066.878.7.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-12-09 at 18:16, Benjamin LaHaise wrote:

> Even better would be to keep the process at low priority while in userland 
> and reverts to normal "nice" priority while in kernelspace.

But the point of a SCHED_IDLE would be to only run them while idle, so
they can still never even get the CPU.

Ahh ... wait, do you mean periodically run them, but only give them the
boost while they are in kernel space?  Very good idea.  Can you see an
easy way to do this?

	Robert Love

