Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290437AbSAXWxz>; Thu, 24 Jan 2002 17:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290454AbSAXWxg>; Thu, 24 Jan 2002 17:53:36 -0500
Received: from ti200710a082-0599.bb.online.no ([148.122.10.87]:8196 "EHLO
	empire.e") by vger.kernel.org with ESMTP id <S290261AbSAXWxb>;
	Thu, 24 Jan 2002 17:53:31 -0500
Message-ID: <3C509067.20108@freenix.no>
Date: Thu, 24 Jan 2002 23:53:27 +0100
From: frode <frode@freenix.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020113
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ext3-users@redhat.com
Subject: Re: OOPS: kernel BUG at transaction.c:1857 on 2.4.17 while rm'ing 700mb file on ext3 partition.
In-Reply-To: <3C502E3A.9070909@freenix.no> <20020124191927.A9564@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:
> On Thu, Jan 24, 2002 at 04:54:34PM +0100, frode wrote:
>>I got the following error while rm'ing a 700mb file from an ext3 partition:
>>Assertion failure in journal_unmap_buffer() at transaction.c:1857:
>>"transaction == journal->j_running_transaction"
> Hmm --- this is not one I think I've ever seen before.

[oops trace snipped]

>>NVRM: loading NVIDIA NVdriver Kernel Module  1.0.2313  Tue Nov 27 12:01:24 PST 2001
> with this driver loaded we really can't make any guarantees about your
> system stability at all.  If you manage to eliminate other oopses and
> still get the ext3 one, even without the NVidia driver loaded, then
> there would be a much better change of debugging things, but right now
> it sounds like a hardware problem.

OK, I rebooted and gzip'ed the NVdriver in /lib/modules... to make sure the 
module doesn't load (lsmod now says my kernel isn't tainted). I'll try using the 
plain 'nv' driver shipped with XFree instead for a while. I tried making another 
700mb iso image and fool around with it (loopback mount it, umount it, then rm 
it) but couldn't trigger anything - but I just spent five minutes trying.

As I mentioned I have had quite a few oopses lately, most of them regarding 
paging etc. (but I'm no kernel expert). See for example
http://marc.theaimsgroup.com/?l=linux-kernel&m=101096234600708&w=2
and
http://marc.theaimsgroup.com/?l=linux-kernel&m=101128528029736&w=2

I'm running linux on an old p100 as well but don't see any problems, so as you 
say I suspected a hardware problem. I ran MemTest86 for about half an hour 
without any errors (but of course there's plenty of other things that may be wrong).

Do you have any suggestions on other ways I could try to put my hardware 
stability on trial, or try to reproduce the bug (to see if it occurs on a 
non-tainted kernel)?

  - Frode

