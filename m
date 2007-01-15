Return-Path: <linux-kernel-owner+w=401wt.eu-S932271AbXAOMNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbXAOMNk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 07:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbXAOMNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 07:13:39 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:58517 "HELO
	embla.aitel.hist.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932271AbXAOMNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 07:13:38 -0500
Message-ID: <45AB6F69.6030004@aitel.hist.no>
Date: Mon, 15 Jan 2007 13:11:21 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Chris Mason <chris.mason@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       dean gaudet <dean@arctic.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org> <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org> <20070112202316.GA28400@think.oraclecorp.com> <45A7F396.4080600@tls.msk.ru>
In-Reply-To: <45A7F396.4080600@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Chris Mason wrote:
> []
>   
>> I recently spent some time trying to integrate O_DIRECT locking with
>> page cache locking.  The basic theory is that instead of using
>> semaphores for solving O_DIRECT vs buffered races, you put something
>> into the radix tree (I call it a placeholder) to keep the page cache
>> users out, and lock any existing pages that are present.
>>     
>
> But seriously - what about just disallowing non-O_DIRECT opens together
> with O_DIRECT ones ?
>   
Please do not create a new local DOS attack.
I open some important file, say /etc/resolv.conf
with O_DIRECT and just sit on the open handle.
Now nobody else can open that file because
it is "busy" with O_DIRECT ?

Helge Hafting
