Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288954AbSAISPq>; Wed, 9 Jan 2002 13:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288956AbSAISPh>; Wed, 9 Jan 2002 13:15:37 -0500
Received: from ns.suse.de ([213.95.15.193]:7686 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288954AbSAISP2>;
	Wed, 9 Jan 2002 13:15:28 -0500
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
In-Reply-To: <200201091741.g09HfAI17240@eng2.beaverton.ibm.com.suse.lists.linux.kernel> <20020109125845.B12609@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 09 Jan 2002 19:15:27 +0100
In-Reply-To: Benjamin LaHaise's message of "9 Jan 2002 19:07:42 +0100"
Message-ID: <p73g05f4chs.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@redhat.com> writes:

> On Wed, Jan 09, 2002 at 09:41:10AM -0800, Badari Pulavarty wrote:
> > Could you please consider this for 2.4.18 release ? If you need the
> > patch on 2.4.18-preX, I can make one quickly.
> 
> Do not apply.  This breaks the majority of databases that run under linux.

It could be done after a check for proper alignment of the user buffer; 
e.g. if buffer aligned to 2^N, submit in 2^N chunks. 

-Andi
