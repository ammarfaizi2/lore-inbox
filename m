Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274549AbRJNGmt>; Sun, 14 Oct 2001 02:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274557AbRJNGmj>; Sun, 14 Oct 2001 02:42:39 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:20996 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S274549AbRJNGma>; Sun, 14 Oct 2001 02:42:30 -0400
Message-ID: <3BC933EA.4636D57C@zip.com.au>
Date: Sat, 13 Oct 2001 23:42:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Recursive deadlock on die_lock
In-Reply-To: <27496.1003033552@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> ...
> If show_registers() fails (which it does far too often on IA64) then
> the system deadlocks trying to recursively obtain die_lock.  Also
> die_lock is never used outside die(), it should be proc local.
> Suggested fix:
> 

Looks to me like it'll work.  But why does ia64 show_registers()
die so easily?  Can it be taught to validate addresses before
dereferencing them somehow?
