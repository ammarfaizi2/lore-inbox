Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbUKVTak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbUKVTak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbUKVTai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:30:38 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51073 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262498AbUKVTYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:24:19 -0500
Message-ID: <41A23D15.3040207@sgi.com>
Date: Mon, 22 Nov 2004 13:25:09 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, Dean Roe <roe@sgi.com>,
       Brian Sumner <bls@sgi.com>, John Hawkes <hawkes@tomahawk.engr.sgi.com>
Subject: Re: scalability of signal delivery for Posix Threads
References: <41A20AF3.9030408@sgi.com> <20041122171932.GA19440@lnx-holt.americas.sgi.com>
In-Reply-To: <20041122171932.GA19440@lnx-holt.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt wrote:
> On Mon, Nov 22, 2004 at 09:51:15AM -0600, Ray Bryant wrote:
> 
>>We've encountered a scalability problem with signal delivery.  Our 
>>application
>>is attempting to use ITIMER_PROF to deliver one signal per clock tick to 
>>each
>>thread of a ptrheaded (NPTL).  These threads are created with CLONE_SIGHAND,
>>so that there is a single sighand->siglock for the entire application.
> 
> 
> Ray, can you provide a simple example application that trips this case?

I'll do that, but it may be after the Thanksgiving holiday when I get it
out to the mailing list.  It's a minor thing, but the test we are using
now is an OpenMP application (written in .c) and I'd propose rewriting
it using POSIX threads without OpenMP for a more general audience

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
