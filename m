Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289684AbSAJVPr>; Thu, 10 Jan 2002 16:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289687AbSAJVPe>; Thu, 10 Jan 2002 16:15:34 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:1244 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289684AbSAJVPZ>;
	Thu, 10 Jan 2002 16:15:25 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201102115.g0ALF1e28859@eng2.beaverton.ibm.com>
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 10 Jan 2002 13:15:01 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16OlMo-0005NV-00@the-village.bc.nu> from "Alan Cox" at Jan 10, 2002 07:00:02 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > Does this address everyones concerns ? I am willing to work with the
> > drivers I tested/reviewed/verified to make the change to set the flag.
> > As driver owners verify their drivers, could set the flag (in future).
> 
> Im just trying to work out how this deals with the 2.4 scsi case
> 

Alan,

The issue with my (mostly) PAGE_SIZE RAW IO patch is, it could generate
buffer heads with different b_size in a single IO request. Jens & Ben
have concerns about some of the low level drivers not able to handle
these. (it would be hard to analyse all the drivers to verify this).

So, Andrea suggested we add a flag in "blk_dev" structure. Only the
drivers which support variable size buffer heads in a single IO will
set it. My RAW VARY patch will use this flag to see if I can do 
RAW VARY or not. Makes sense ?

Let me know, what you think about this approach.

Regards,
Badari
