Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVCBQ0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVCBQ0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVCBQ0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:26:48 -0500
Received: from mail0.lsil.com ([147.145.40.20]:37543 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262337AbVCBQ0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:26:30 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CBEC@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>,
       Vasily Averin <vvs@sw.ru>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: v2.4 megaraid2 update Re: [PATCH] Prevent NMI oopser
Date: Wed, 2 Mar 2005 11:26:06 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo,

As per our offline conversation, I have verified the update that went into
2.4.30-pre2.
I confirm that all changes are correct. I have only one doubt: The driver
was using
sleep_on_timeout  for lack of msleep. Should it start using msleep now?

Vasily & Andrey, thank you for your efforts.

Thanks,
Sreenivas
LSI LOGIC Corporation


>-----Original Message-----
>From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com] 
>Sent: Wednesday, February 23, 2005 2:06 AM
>To: Andrey J. Melnikoff (TEMHOTA); Vasily Averin
>Cc: Matt Domsch; linux-kernel@vger.kernel.org; Mukker, Atul; 
>Bagalkote, Sreenivas
>Subject: v2.4 megaraid2 update Re: [PATCH] Prevent NMI oopser
>
>
>Hi, 
>
>As the megaraid2 maintainers dont seem to care about v2.4 
>mainline at all, completly 
>ignoring my requests to fix the NMI oopser bug for several 
>months, I'm applying the RHEL3 
>update + inline reordering, which should do it.
>
>At this point I'm quite sure they wont answer this message either.  :( 
>
>Thanks Vasily and Andrey.
>
>On Mon, Feb 07, 2005 at 11:27:45PM +0300, Andrey J. Melnikoff 
>(TEMHOTA) wrote:
>> Hi Matt, Marcelo!
>>  On Wed, Feb 02, 2005 at 02:19:14PM -0600, Matt Domsch wrote next:
>> 
>> > On Wed, Feb 02, 2005 at 10:32:28PM +0300, Vasily Averin wrote:
>> > > >As a hack, one could #define inline /*nothing*/ in 
>megaraid2.h to
>> > > >avoid this, but it would be nice if the functions could all get
>> > > >reordered such that inlining works properly, and the 
>need for function
>> > > >declarations in megaraid2.h would disappear completely.
>> > > 
>> > > 
>> > > Could you fix it by additional patch? Or you going to 
>prepare a new one?
>> 
>> Any chance to include this two patches before 2.4.30 release?
>> 
>> Vasily Averin patch:
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=110737085714273&w=2
>> And my (incremental) patch:
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=110738438005846&w=2
>
