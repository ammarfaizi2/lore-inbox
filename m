Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291661AbSBHRYB>; Fri, 8 Feb 2002 12:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291664AbSBHRXv>; Fri, 8 Feb 2002 12:23:51 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:32322 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S291660AbSBHRXf>; Fri, 8 Feb 2002 12:23:35 -0500
Message-ID: <3C640994.F3528E74@redhat.com>
Date: Fri, 08 Feb 2002 17:23:32 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] larger kernel stack (8k->16k) per task
In-Reply-To: <20020208110930.C1429@devserv.devel.redhat.com> <Pine.LNX.4.33.0202081645170.1359-100000@einstein.homenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> 
> On Fri, 8 Feb 2002, Arjan van de Ven wrote:
> > If you need even more in your code (I assume you do otherwise you wouldn't
> > have done the work) then I really suggest you take a long hard look and fix
> > the obvious bugs or the design....
> 
> Arjan, I completely agree with you, but please do not overlook one obvious
> thing -- sometimes (well, most of the time) in order to fix those stack
> corruption issues you _first_ need to apply this patch and then it becomes
> obvious that the reason for this "random" corruption is the stack

Well, there's also a simple script you can run on the vmlinux to catch
big offenders....
I can even see the point of running that at the end of "make bzImage"
and abort or
at least seriously warn if there are offenders that, say, allocate more
than 2Kb of stackspace.
