Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281560AbRKRWym>; Sun, 18 Nov 2001 17:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281578AbRKRWyc>; Sun, 18 Nov 2001 17:54:32 -0500
Received: from jalon.able.es ([212.97.163.2]:46556 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S281560AbRKRWyT>;
	Sun, 18 Nov 2001 17:54:19 -0500
Date: Sun, 18 Nov 2001 23:54:12 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Charles Marslett <cmarslett9@cs.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, James A Sutherland <jas88@cam.ac.uk>,
        war <war@starband.net>, linux-kernel@vger.kernel.org
Subject: Re: Swap
Message-ID: <20011118235412.A2171@werewolf.able.es>
In-Reply-To: <3BF82443.5D3E2E11@starband.net> <E165ZRi-000718-00@mauve.csi.cam.ac.uk> <20011118230540.A2042@werewolf.able.es> <3BF837F9.C7424E5C@cs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3BF837F9.C7424E5C@cs.com>; from cmarslett9@cs.com on Sun, Nov 18, 2001 at 23:36:41 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011118 Charles Marslett wrote:
>"J.A. Magallon" wrote:
>> On 20011118 James A Sutherland wrote:
>> >On Sunday 18 November 2001 9:12 pm, war wrote:
>> >> It is amazing that I could run all of that stuff, because:
>> >>
>> >> When I have swap on, and if I run all of those programs, 200-400MB of
>> >> swap is used.
>> >
>> >Yep. There's a reason for that: the kernel is *ALWAYS* able to swap pages out
>> >to disk - even without "swap space". Disabling swapspace simply forces the
>> >kernel to swap out more code, since it cannot swap out any data.
>> 
>> Sure ??? Where ?? What disk space uses it to swap pages to ?
>
>The code is "swapped" to the original file it was loaded from.  You just
>free up the pages for someone else to use until you get a page fault in that
>task, then reload it from the original executable.  That may have something
>to do with the fact that he gets better performance without a swap file allocated,
>since code swaps never write, only read (half as much disk I/O).  I could see

Yup, I missed mmapped pages. You can drop them and reread, yes. 

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.15-pre6-beo #1 SMP Sun Nov 18 10:25:01 CET 2001 i686
