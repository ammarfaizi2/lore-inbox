Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280434AbRKEJ7P>; Mon, 5 Nov 2001 04:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280432AbRKEJ7G>; Mon, 5 Nov 2001 04:59:06 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:40613 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280434AbRKEJ6u>;
	Mon, 5 Nov 2001 04:58:50 -0500
Date: Mon, 05 Nov 2001 09:58:46 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <673187710.1004954326@[195.224.237.69]>
In-Reply-To: <672366870.1004953505@[195.224.237.69]>
In-Reply-To: <672366870.1004953505@[195.224.237.69]>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I was slightly too brief:

> --On Monday, 05 November, 2001 12:54 AM -0500 "Albert D. Cahalan"
> <acahalan@cs.uml.edu> wrote:
>
>> By putting directories far apart, you leave room for regular
>> files (added at some future time) to be packed close together.
>
> Mmmm... but if you read ahead your directories (see lkml passim)
> I'd be prepared to be the gain here is either minimized, or
> negative.

IE if you put in code to queue a cache a subdirectory when it's
entry in the parent is enumerated (either in userland or
in kernelland), then you get far less seeking as it all
comes 'up front' and the seeks can be monotonic. However,
still the closer the directories are, the better.

But more to the point, if your directories tend to be cached
this way, you surely win by having the directories allocated
the same way as files (i.e. to be packed /all/ close together).

--
Alex Bligh
