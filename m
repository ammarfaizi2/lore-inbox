Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSEPMyC>; Thu, 16 May 2002 08:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSEPMyB>; Thu, 16 May 2002 08:54:01 -0400
Received: from ns.suse.de ([213.95.15.193]:25359 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312558AbSEPMyB>;
	Thu, 16 May 2002 08:54:01 -0400
To: Mark Gross <mgross@unix-os.sc.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B485B@orsmsx111.jf.intel.com.suse.lists.linux.kernel> <20020515120722.A17644@in.ibm.com.suse.lists.linux.kernel> <20020515140448.C37@toy.ucw.cz.suse.lists.linux.kernel> <200205152353.g4FNrew30146@unix-os.sc.intel.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 16 May 2002 14:54:00 +0200
Message-ID: <p73it5oz21j.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Gross <mgross@unix-os.sc.intel.com> writes:
> 
> Any driver that holds a lock across any sleep_on call I think is abusing 
> locks and needs adjusting.

That's true for spinlocks, but not for semaphores. The mm layer and the 
vfs layer both use semaphores extensively and sleep with them hold, 
also some other subsystems (like networking) use sleeping locks.

-Andi

