Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265664AbTFNLOa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 07:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265665AbTFNLOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 07:14:30 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:24201 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265664AbTFNLO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 07:14:29 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC] recursive pagetables for x86 PAE
Date: Sat, 14 Jun 2003 13:27:48 +0200
User-Agent: KMail/1.5.1
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
References: <1055540875.3531.2581.camel@nighthawk>
In-Reply-To: <1055540875.3531.2581.camel@nighthawk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306141327.48649.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 13. Juni 2003 23:47 schrieb Dave Hansen:
> When you have lots of tasks, the pagetables start taking up lots of
> lowmem.  We have the ability to push the PTE pages into highmem, but
> that exacts a penalty from the atomic kmaps which, depending on
> workload, can be a 10-15% performance hit.
>
> The following patches implement something which we like to call UKVA.
> It's a Kernel Virtual Area which is private to a process, just like
> Userspace.  You can put any process-local data that you want in the
> area.  But, for now, I just put PTE pages in there.

If you put only such pages there, do you really want that memory to
be per task? IMHO it should be per memory context to aid threading
performance.

Secondly, doesn't this scream for using large pages?

	Regards
		Oliver

