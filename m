Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288867AbSBDKsR>; Mon, 4 Feb 2002 05:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288878AbSBDKsH>; Mon, 4 Feb 2002 05:48:07 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:10142 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288867AbSBDKr6>; Mon, 4 Feb 2002 05:47:58 -0500
Message-ID: <3C5E66DB.6B1B2BDC@redhat.com>
Date: Mon, 04 Feb 2002 10:47:55 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <20020204044055.EF0579251@oscar.casa.dyndns.org> <Pine.LNX.4.33.0202041330401.4090-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Sun, 3 Feb 2002, Ed Tomlinson wrote:
> 
> > One point that seems to get missed is that a group of java threads,
> > posix threads or sometimes forked processes combine to make an
> > application. [...]
> 
> yes - but what makes them an application is not really the fact that they
> share the VM (i can very much imagine thread-based login servers where
> different users use different threads - a single application as well?),
> but the intention of the application designer, which is hard to guess.

sharing the same Thread Group ID would be a very obvious quantity to
check,
and would very much show the indication of the application author.
