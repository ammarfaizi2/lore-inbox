Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289067AbSAIWpb>; Wed, 9 Jan 2002 17:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289066AbSAIWpV>; Wed, 9 Jan 2002 17:45:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14099 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289067AbSAIWpO>; Wed, 9 Jan 2002 17:45:14 -0500
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: pbadari@us.ibm.com (Badari Pulavarty)
Date: Wed, 9 Jan 2002 22:56:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, andrea@suse.de,
        pbadari@us.ibm.com
In-Reply-To: <200201091741.g09HfAI17240@eng2.beaverton.ibm.com> from "Badari Pulavarty" at Jan 09, 2002 09:41:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OReG-0002Zi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is a 2.4.17 patch for doing PAGE_SIZE IO on raw devices. Instead 
> of doing 512 byte buffer heads, the patch does 4K buffer heads. This
> patch significantly reduced CPU overhead and increased IO throughput
> in our database benchmark runs. (CPU went from 45% busy to 6% busy).

Does that work out when the application is still doing 512 byte raw I/O.
Its fine to fall back to the current performance but at least one very
large competing database would get quite irate if the fallback made
512 byte mode slower or nonfunctional ?

Alan
