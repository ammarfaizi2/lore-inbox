Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132178AbRCVUWR>; Thu, 22 Mar 2001 15:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132183AbRCVUWH>; Thu, 22 Mar 2001 15:22:07 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:21766
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S132178AbRCVUVv>; Thu, 22 Mar 2001 15:21:51 -0500
Date: Thu, 22 Mar 2001 15:21:00 -0500
From: Chris Mason <mason@suse.com>
To: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: 2.4.2 fs/inode.c
Message-ID: <426210000.985292460@tiny>
In-Reply-To: <20010322190452.C7756@redhat.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, March 22, 2001 07:04:52 PM +0000 "Stephen C. Tweedie"
<sct@redhat.com> wrote:

> Hi,
> 
> On Thu, Mar 22, 2001 at 01:42:15PM -0500, Jan Harkes wrote:
>> 
>> I found some code that seems wrong and didn't even match it's comment.
>> Patch is against 2.4.2, but should go cleanly against 2.4.3-pre6 as well.
>  
> Patch looks fine to me.  Have you tested it?  If this goes wrong,
> things break badly...

This should only affect reiserfs, and it should be a good thing.  I'll do
some tests, thanks for spotting.

> 
>>  		/* Don't do this for I_DIRTY_PAGES - that doesn't actually dirty the
>>  		inode itself */ -		if (flags & (I_DIRTY | I_DIRTY_SYNC)) {
>> +		if (flags & (I_DIRTY_SYNC | I_DIRTY_DATASYNC)) {

-chris

