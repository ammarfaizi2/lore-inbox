Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUAUCIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 21:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbUAUCIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 21:08:41 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:11728 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265900AbUAUCIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 21:08:39 -0500
Subject: Re: struct task_struct -> task_t
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: mort@bork.org, viro@parcelfarce.linux.theplanet.co.uk,
       bluefoxicy@linux.net
Content-Type: text/plain
Organization: 
Message-Id: <1074642648.828.40311.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Jan 2004 18:50:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Hicks writes:
> On Mon, Jan 19, 2004 at 10:24:34PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
>> On Mon, Jan 19, 2004 at 02:17:57PM -0800, john moser wrote:

>>> It has come to my attention that in some places
>>> in the kernel, 'struct task_struct' is used; and
>>> in others, 'task_t' is used.  Also, 'task_t' is
>>> 'typedef struct task_struct task_t;'.
>>>
>>> I made a small script to change around as much
>>> as I could so that everything uses task_t,
>>
>> What the fsck for?  If anything, the opposite
>> (and removal of that typedef) would be preferable.
>
> John,
>
> As Al is trying to point out, we try to discourage
> the use of typedefs in the kernel.  It is much
> easier to see that blah_t is really a struct if
> we always use 'struct blah'.

That's no good for variable usage. We don't
write "struct current".

You're giving the argument for Hungarian
notation. Not that I'd suggest it, but that
is where your argument leads.

IMHO, we type too much already.


