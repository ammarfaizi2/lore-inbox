Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTKCTGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 14:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTKCTGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 14:06:42 -0500
Received: from mail.broadpark.no ([217.13.4.2]:58592 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S262161AbTKCTGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 14:06:41 -0500
To: sankar <san_madhav@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: pthread mutex question
References: <Sea2-DAV35RuMrzpeSK0000db71@hotmail.com> <oprxxqjgqeq1sf88@mail.broadpark.no> <Sea2-DAV50kJcj3CRIn0000c736@hotmail.com>
Message-ID: <oprx2sn6x1q1sf88@mail.broadpark.no>
From: Arve Knudsen <aknuds-1@broadpark.no>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Mon, 03 Nov 2003 20:05:56 +0100
In-Reply-To: <Sea2-DAV50kJcj3CRIn0000c736@hotmail.com>
User-Agent: Opera7.21/Linux M2 build 480
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're probably looking at the abstract model. Download the source and 
look at timed_mutex::do_timedlock, in mutex.cpp.

Regards

Arve Knudsen

On Mon, 3 Nov 2003 09:07:47 -0800, sankar <san_madhav@hotmail.com> wrote:

> Thx for the info...I lookd in boost.org..It does not have the source code
> for timed mutex.It just says how it shd work..Pls let me know if I am
> missing something  here..
> ----- Original Message -----
> From: "Arve Knudsen" <aknuds-1@broadpark.no>
> To: "sankar" <san_madhav@hotmail.com>; <linux-kernel@vger.kernel.org>
> Sent: Friday, October 31, 2003 5:31 PM
> Subject: Re: pthread mutex question
>
>
>> Its C++, but you could have a look at the boost::thread::timed_mutex
>> (www.boost.org) implementation, which makes use of 
>> pthread_cond_timedwait.
>>
>> Regards
>>
>> Arve Knudsen
>>
>> On Fri, 31 Oct 2003 16:43:14 -0800, sankar <san_madhav@hotmail.com> 
>> wrote:
>>
>> > Hi,
>> > I am looking for an idea as to how to implement timed mutex using
> pthread
>> > libraries on linux.
>> > Basically I want to associate a timeout value with the wait function 
>> i,e
>> > pthread_mutex_lock() which returns once the timeout expires instaed of
>> > waiting for ever.
>> > Pls help
>> >
>> > thx..
>> >
>> > Sankarshana M
>>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
