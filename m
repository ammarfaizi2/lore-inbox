Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281083AbRKTOwT>; Tue, 20 Nov 2001 09:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281084AbRKTOwK>; Tue, 20 Nov 2001 09:52:10 -0500
Received: from jalon.able.es ([212.97.163.2]:25812 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S281083AbRKTOvu>;
	Tue, 20 Nov 2001 09:51:50 -0500
Date: Tue, 20 Nov 2001 15:51:43 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: James A Sutherland <jas88@cam.ac.uk>
Cc: Remco Post <r.post@sara.nl>, linux-kernel@vger.kernel.org
Subject: Re: Swap
Message-ID: <20011120155143.A4597@werewolf.able.es>
In-Reply-To: <200111191051.LAA04099@zhadum.sara.nl> <E165oY1-0006Db-00@mauve.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E165oY1-0006Db-00@mauve.csi.cam.ac.uk>; from jas88@cam.ac.uk on Mon, Nov 19, 2001 at 14:33:22 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011119 James A Sutherland wrote:
>On Monday 19 November 2001 10:51 am, Remco Post wrote:
>> --8<--
>>
>> > Except that openoffice and mozilla can be swapped out in BOTH cases: the
>> > kernel can discard mapped pages and reread as needed, whether you have a
>> > swap partition or not.
>>
>> No they can't without swap, nothing can be SWAPPED out. The code pages can
>> be paged out (discarded), but no SWAPPING takes place.
>
>OK, s/swapped/paged/.
>

Not so OK.

AFAIK, that is all a question of names. All is the same. Old systems
like MacOS do SWAP, because when they send something to disk they send the
whole app with its data space to disk. Linux does not send a whole app to
disk, but individual pages, so it does SWAP AT PAGE LEVEL, or paging. When
a page is deleted for one executable (because we can re-read it from on-disk
binary), it is discarded, not paged out. A page is paged-out if it is written
to disk.
So _swaping_ and _paging_ are the same, but with different granularity.

(of course, flame and correct me if I'm wrong...)

>> > Whereas without swapspace, only the read-only mapped pages can be swapped
>> > out.
>>

They are not swapped-out, just discarded to be re-read.

>
>By your definition, Linux does not swap, ever. It only "pages". This is what 
>I was referring to as swapping, since this involves the SWAPspace/partition, 
>rather than PAGEfile :)
>

It is the same. You can page-out (because Linux never do swap, as the process
of sending a whole app to disk), to an specially formatted partition or to
a file. If you are going to be pedantic, linux really uses _page_partitions_
and _page_files_, instead of swap-partitions and swap-files.

BTW, there is soft for mac that changes the swap algorithm from app level to
page level and they called it "RamDoubler", and people still thinks its
magic...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.15-pre6-beo #1 SMP Sun Nov 18 10:25:01 CET 2001 i686
