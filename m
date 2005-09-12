Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVILTDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVILTDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVILTDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:03:33 -0400
Received: from mail-gw2.turkuamk.fi ([195.148.208.126]:53973 "EHLO
	mail-gw2.turkuamk.fi") by vger.kernel.org with ESMTP
	id S932077AbVILTDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:03:33 -0400
Message-ID: <4325D150.6040505@kolumbus.fi>
Date: Mon, 12 Sep 2005 22:04:48 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.5.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/2] i386: consolidate discontig functions into normal
 ones
References: <20050912175319.7C51CF96@kernel.beaverton.ibm.com>
In-Reply-To: <20050912175319.7C51CF96@kernel.beaverton.ibm.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.13a
  |April 8, 2004) at 12.09.2005 22:03:20,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP1|June
 19, 2005) at 12.09.2005 22:03:54,
	Serialize complete at 12.09.2005 22:03:54
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

>There are quite a few functions in i386's discontig.c which are
>actually NUMA-specific, not discontigmem.  They are also very
>similar to the generic, flat functions found in setup.c.
>
>This patch takes the versions in setup.c and makes them work
>for both NUMA and non-NUMA cases.  In the process, quite a
>few nasty #ifdef and externs can be removed.
>
>One of the main mechanisms to do this is that highstart_pfn
>and highend_pfn are now gone, replaced by node_start/end_pfn[].
>However, this has no real impact on storage space, because
>those arrays are declared with a length of MAX_NUMNODES, which
>is 1 when NUMA is off.
>
>
>  
>
I think you allocate remap pages for nothing in the flatmem case for 
node0...those aren't used for the mem map in !NUMA.

--Mika

