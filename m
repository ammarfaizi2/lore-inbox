Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUE1Q6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUE1Q6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 12:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUE1Q6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 12:58:30 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:12334 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261724AbUE1Q6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 12:58:23 -0400
In-Reply-To: <20040528164544.GF422@louise.pinerecords.com>
References: <20040528122854.GA23491@clipper.ens.fr> <1085748363.22636.3102.camel@watt.suse.com> <20040528162450.GE422@louise.pinerecords.com> <1085761753.22636.3329.camel@watt.suse.com> <20040528164544.GF422@louise.pinerecords.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <38445FF4-B0C8-11D8-B96B-000A95CC3A8A@mesatop.com>
Content-Transfer-Encoding: 7bit
Cc: David Madore <david.madore@ens.fr>, Chris Mason <mason@suse.com>,
       linux-kernel@vger.kernel.org
From: Steven Cole <elenstev@mesatop.com>
Subject: Re: filesystem corruption (ReiserFS, 2.6.6): regions replaced by \000 bytes
Date: Fri, 28 May 2004 10:58:19 -0600
To: Tomas Szepe <szepe@pinerecords.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 28, 2004, at 10:45 AM, Tomas Szepe wrote:

> On May-28 2004, Fri, 12:29 -0400
> Chris Mason <mason@suse.com> wrote:
>
>> On Fri, 2004-05-28 at 12:24, Tomas Szepe wrote:
>>> On May-28 2004, Fri, 08:46 -0400
>>> Chris Mason <mason@suse.com> wrote:
>>>
>>>>> The bottom line: I've experienced file corruption, of the following
>>>>> nature: consecutive regions (all, it seems, aligned on 256-byte
>>>>> boundaries, and typically around 1kb or 2kb in length) of seemingly
>>>>> random files are replaced by null bytes.
>>>>
>>>> The good news is that we tracked this one down recently.  2.6.7-rc1
>>>> shouldn't do this anymore.
>>>
>>> So did this only affect SMP machines?
>>
>> No, if you slept in the right spot you could hit it on UP.
>
> Uh oh.  Any idea about when the bug was introduced?
>

As far as I know, I was the first to publicly complain about
the bug, first to Bitmover, (I was hitting it when using bk)
who then figured out that it was a kernel bug, hence the
long "1352 NUL bytes at end of page" thread.

I first noticed the bug around April 15, doing almost nightly
kernel updates and builds.  The bug was rather hard to hit
reliably though, so it could have been there for some time
earlier.

Steven

