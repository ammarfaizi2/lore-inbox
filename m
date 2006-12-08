Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164196AbWLHAJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164196AbWLHAJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 19:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164193AbWLHAJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 19:09:53 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:59757 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164194AbWLHAJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 19:09:52 -0500
Message-ID: <0bb201c71a5d$1125a930$eeeea8c0@aldipc>
From: "roland" <devzero@web.de>
To: "Andrew Morton" <akpm@osdl.org>, "Jay Lan" <jlan@engr.sgi.com>
Cc: "Fengguang Wu" <fengguang.wu@gmail.com>, <linux-kernel@vger.kernel.org>,
       <lserinol@gmail.com>
References: <0e2001c6de7a$fe756280$962e8d52@aldipc><359067036.19509@ustc.edu.cn><008f01c6e27a$f9bd5460$962e8d52@aldipc><20060927155549.4a69490d.akpm@osdl.org><451C1AAA.3090301@engr.sgi.com><20060928120952.9f09cbf7.akpm@osdl.org><451C45F1.1050604@engr.sgi.com> <20060928151409.f0a9bda7.akpm@osdl.org>
Subject: Re: I/O statistics per process
Date: Fri, 8 Dec 2006 01:09:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

didn`t discover that there is anything new about this (andrew? jay?) or if 
some other person sent a patch , but i`d like to report that i came across a 
really nice tool which would immediately benefit from per-process i/o 
statistics feature.

please - this mail is not meant to clamor for such feature - it`s just to 
show up some more benefits if this feature would exist.

vmktree at http://vmktree.org/ is some really nice monitoring tool being 
able to graph performance statistics for a host running vmware virtual 
machines (closed source - evil -  i know ;) - and it can break that 
statistics down to each virtual machine.

what`s hurting mostly here is that you have no clue how much I/O each of 
those virtual machine is generating - you may give sort of a "guess" that a 
machine with 100% idle cpu will not generate any significant amount of I/O, 
but vmktree would be so much more powerful with a per-process I/O statistic, 
since you can use your systems more efficient, because you would know about 
you I/O hogs, too.

having the ability to take such information from /proc would be a real 
killer feature - good for troubleshooting and also good for getting 
important statistics!

roland

ps:
this is another person, desperately seeking for a tool providing that 
information:  http://www.tek-tips.com/viewthread.cfm?qid=1284288&page=4




----- Original Message ----- 
From: "Andrew Morton" <akpm@osdl.org>
To: "Jay Lan" <jlan@engr.sgi.com>
Cc: "roland" <devzero@web.de>; "Fengguang Wu" <fengguang.wu@gmail.com>;
<linux-kernel@vger.kernel.org>; <lserinol@gmail.com>
Sent: Thursday, September 28, 2006 11:14 PM
Subject: Re: I/O statistics per process


> On Thu, 28 Sep 2006 15:00:17 -0700
> Jay Lan <jlan@engr.sgi.com> wrote:
>
>> >>>    in __set_page_dirty_[no]buffers().) (But that ends up being wrong
>> >>> if
>> >>>    someone truncates the file before it got written)
>> >>>
>> >>> - it doesn't account for file readahead (although it easily could)
>> >>>
>> >>> - it doesn't account for pagefault-initiated readahead (it could)
>> >>>
>>
>> Mmm, i am not a true FS I/O person. The data collection patches i
>> submitted in Nov 2004 was the code i inherited and has been
>> used in production system by our CSA customers. We lost a bit in
>> contents and accuracy when CSA was ported from IRIX to Linux. I am
>> sure there is room for improvement without much overhead.
>
> OK, well it sounds like we're free to define these in any way we like.  So
> we actually get to make them mean something useful - how nice.
>
> I hereby declare: "approxmiately equal to the number of filesystem bytes
> which this task has caused to occur, or which shall occur in the near
> future".
>
>> Maybe FS
>> I/O guys can chip in?
>
> I used to be one of them.  I can take a look at doing this.  Given the
> lack
> of any applciation to read the darn numbers out I guess I'll need to
> expose
> them in /proc for now.  Yes, that monitoring patch (and an application to
> read from it!) would be appreciated, thanks.
>

