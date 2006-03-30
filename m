Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWC3Rbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWC3Rbg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 12:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWC3Rbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 12:31:36 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:43809 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751335AbWC3Rbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 12:31:35 -0500
Message-ID: <442C15F0.4000204@cfl.rr.com>
Date: Thu, 30 Mar 2006 12:31:28 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ram Gupta <ram.gupta5@gmail.com>
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: How to determine the start of DATA segment
References: <728201270603300837g60eefb65u8b55df910b86f6c4@mail.gmail.com>
In-Reply-To: <728201270603300837g60eefb65u8b55df910b86f6c4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Mar 2006 17:31:46.0613 (UTC) FILETIME=[D1BC3650:01C6541F]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14355.000
X-TM-AS-Result: No--4.100000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The program's DATA segment is of fixed size as link time.  It contains 
all of the initialized variables your program has.  It does not grow at 
runtime.  You can find out how large it is by looking at the output of 
objdump.  Maybe you meant to ask what is the upper limit on the size of 
your heap?

Ram Gupta wrote:
> Is there a system call or library function which a process can use to
> determine the start of its data segment . I need to know the start of
> the data segment so that process does not cross its DATA limit. Using
> this information & sbrk it knows how much data space is already used &
> how much it can grow further without crossing the limit.
> 
> Thanks
> Ram Gupta
