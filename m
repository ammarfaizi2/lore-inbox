Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131484AbRC0TWK>; Tue, 27 Mar 2001 14:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131485AbRC0TVx>; Tue, 27 Mar 2001 14:21:53 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:24589
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S131484AbRC0TVj>; Tue, 27 Mar 2001 14:21:39 -0500
Date: Tue, 27 Mar 2001 14:20:50 -0500
From: Chris Mason <mason@suse.com>
To: Christoph Lameter <christoph@lameter.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS phenomenon with 2.4.2 ac24/ac12
Message-ID: <393460000.985720850@tiny>
In-Reply-To: <Pine.LNX.4.21.0103271113410.7500-100000@home.lameter.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, March 27, 2001 11:14:57 AM -0800 Christoph Lameter
<christoph@lameter.com> wrote:

> On Tue, 27 Mar 2001, Chris Mason wrote:
> 
>> Just to make sure I understand, you had the exact same errors before
>> running fsck?  Same files could not be deleted?
> Correct.
> 
>> > I think this is a problem with the reiserfs code in the kernel. I never
>> > ran reiserfsck before this problem surfaced. The problem arose in the
>> > netscape cache directory with lots of small files. Guess the tail
>> > handling is not that stable yet?
>> 
>> I wish I could blame it on the tail code ;-)  None of the bugs fixed
>> there would have caused this, and they should be completely unrelated.
>> I'll try some tests in oom situations to try and reproduce.  It could
>> also be caused by hashing errors.  If you formatted with r5 hash, was
>> the partition ever incorrectly detected as tea hash?
> 
> No idea. I never got that deep into reiser.

I should have been more clear.  Everyt ime you mount the filesystem, a it
prints the hash used.  This is probably recorded in your log files, either
'Using r5 hash to sort names' or 'Using tea hash to sort names'.  For any
given filesystem, it should never switch from one to the other.

> 
>> > How do I get rid of the /a/yy directory now?
>> 
>> With fsck.  I'll grab the latest today and make sure it can fix this bug.
>> Until then, mv /a/yy /a/yy.broken and mkdir /a/yy.
> 
> /a/yy is already a "broken" dir moved out of the way.
> 

Ok, I'll get back to you later on fsck.

-chris




