Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264008AbTDJIvj (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 04:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbTDJIvj (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 04:51:39 -0400
Received: from dial-ctb05177.webone.com.au ([210.9.245.177]:11013 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264008AbTDJIvi (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 04:51:38 -0400
Message-ID: <3E953317.1090406@cyberone.com.au>
Date: Thu, 10 Apr 2003 19:02:15 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Ansell <keitha@edp.fastfreenet.com>
CC: Andrew Morton <akpm@digeo.com>, Andre Hedrick <andre@linux-ide.org>,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: bdflush flushing memory mapped pages.
References: <007601c2fecd$12209070$230110ac@kaws><Pine.LNX.4.10.10304090209440.12558-100000@master.linux-ide.org> <20030409022726.1ec93a0f.akpm@digeo.com> <01bc01c2ff9d$0dc1aca0$230110ac@kaws>
In-Reply-To: <01bc01c2ff9d$0dc1aca0$230110ac@kaws>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Keith Ansell wrote:

>Thank you for your prompt replies.
>
>I realise that Linux conforms to the letter of the specification, but maybe
>not the spirit of the it.
>
>I am porting a Database solution to Linux from Unix SVR4, Sco OpenServer and
>AIX, where all write required memory mapped files are flushed to disk with
>the system flusher, my users have large systems (some in excess of 600
>concurrent connections) flushing memory mapped files is a big part of are
>systems performance.  This ensures that in the event of a catastrophic
>system failure the customers vitual business data has been written to disk .
>
As Andrew mentioned, msync would do what you want. It seems
to me though, that your database solution wants a stronger
guarantee about the safety of the data than asynchronous
writes will provide anyway.

