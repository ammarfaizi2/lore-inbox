Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287359AbSBHPhD>; Fri, 8 Feb 2002 10:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291611AbSBHPgx>; Fri, 8 Feb 2002 10:36:53 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:460 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287359AbSBHPgd>; Fri, 8 Feb 2002 10:36:33 -0500
Message-ID: <3C63F07F.323A32DE@redhat.com>
Date: Fri, 08 Feb 2002 15:36:31 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] larger kernel stack (8k->16k) per task
In-Reply-To: <Pine.LNX.4.33.0202081511400.1359-100000@einstein.homenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> 
> Hi,
> 
> In the light of some talks here about increasing kernel stack, here is my
> patch for i386 architecture that some may find useful. It also has a nice
> extra (/proc/stack) implemented by Hugh Dickins which helps to find major
> offenders.
> 
> It is against 2.4.9 but should be easy to port in any direction. (One way
> the patch could be improved is by making the size CONFIG_ option instead
> of hardcoding). Oh btw, please don't tell me "but now you'd need _four_
> physically-contiguous pages to create a task instead of two!" because I
> know it (and think it's not too bad).


I do think it is too bad. Sorry.
Also it's the wrong approach. The right approach (as done by Manfred and
David) is
to put "current" no longer on this stack just a pointer to current.
And .... if you need a 16Kb stack your kernel code is VERY VERY sick.

Greetings,
   Arjan van de Ven
