Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289084AbSAIXtF>; Wed, 9 Jan 2002 18:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289086AbSAIXs4>; Wed, 9 Jan 2002 18:48:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:9607 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289084AbSAIXsp>;
	Wed, 9 Jan 2002 18:48:45 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201092348.g09NmHg25671@eng2.beaverton.ibm.com>
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 9 Jan 2002 15:48:17 -0800 (PST)
Cc: pbadari@us.ibm.com (Badari Pulavarty), bcrl@redhat.com (Benjamin LaHaise),
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, andrea@suse.de
In-Reply-To: <E16ORfZ-0002Zu-00@the-village.bc.nu> from "Alan Cox" at Jan 09, 2002 09:58:05 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

> 
> > If it is not reasonable to fix all the brokern drivers,
> > how about making this configurable (to do variable size IO) ?
> > Do you favour this solution ?
> 
> We have hardware that requires aligned power of two for writes (ie 4K on
> 4K boundaries only). The 3ware is one example Jeff Merkey found
> 

emm.. come to think of it, I can easily (2 line) change my patch to
do 512 byte buffer heads till we get PAGE alignment and then start
issuing 4K IO buffer heads. What do you think ? will this work ? 

And also, do you know any low level drivers Ben mentioning:

> low level drivers, some of which assume that 
> all buffer heads within a request have the same block size.

Is it still true for 2.4 ? 

Regards,
Badari
