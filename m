Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbRGKRZC>; Wed, 11 Jul 2001 13:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbRGKRYw>; Wed, 11 Jul 2001 13:24:52 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:51471
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S265754AbRGKRYi>; Wed, 11 Jul 2001 13:24:38 -0400
Date: Wed, 11 Jul 2001 13:23:56 -0400
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>,
        Brian Strand <bstrand@switchmanagement.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
Message-ID: <145960000.994872235@tiny>
In-Reply-To: <20010711190821.K3496@athlon.random>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, July 11, 2001 07:08:21 PM +0200 Andrea Arcangeli
<andrea@suse.de> wrote:

> On Wed, Jul 11, 2001 at 09:44:19AM -0700, Brian Strand wrote:
>> Our Oracle configuration is on reiserfs on lvm on Mylex.  Our workload 
>> is not entirely cached, as we are working against an 8GB table, Oracle 
>> is configured to use slightly more than 1GB of memory, and there is 
>> always several MB/s of IO going on during our queries.  The "working 
>> set" of the main table and indexes occupies over 2GB.
> 
> As I suspected there is the VM in our way. Also reiserfs could be an
> issue but I am not aware of any regression on the reiserfs side, Chris?

reiserfs has a big O_SYNC penalty right now, which can be fixed by a
transaction tracking patch I posted a month or so ago.  It has been tested
by a few people as a large improvement.  Brian, I'll update this to 2.4.6
and send along.

-chris

