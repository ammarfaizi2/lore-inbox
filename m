Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135185AbRDROuo>; Wed, 18 Apr 2001 10:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135196AbRDROuf>; Wed, 18 Apr 2001 10:50:35 -0400
Received: from geos.coastside.net ([207.213.212.4]:8393 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S135185AbRDROuY>; Wed, 18 Apr 2001 10:50:24 -0400
Mime-Version: 1.0
Message-Id: <p05100b30b7035836974c@[207.213.214.34]>
In-Reply-To: <3ADD4D46.3E8CF0B2@canit.se>
In-Reply-To: <E14pef6-0003Vj-00@the-village.bc.nu>
 <3ADD4D46.3E8CF0B2@canit.se>
Date: Wed, 18 Apr 2001 07:45:05 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: IP Acounting Idea for 2.5
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:16 AM +0200 2001-04-18, Kenneth Johansson wrote:
>Alan Cox wrote:
>
>> > > Fix your userspace applications to behave correctly.  If _you_
>> > > require your userspace applications to not clear counters, then fix
>> > > the application.
>> >
>> > You are confused.  What would you say if a close() by another,
>>
>> No he isnt confused, you are trying to dictate policy.
>
>Well it's not actually possible to do a fix in userspace for a odometer type of counter that can be reset. I don't know what you mean about policy but this reset "feature" is a shure way to get bad values. I have not seen one good reason to have a reset other than it easier to read and that is something that can be fixed in userspace.

Moreover, in a non-resettable-counter environment, any client of the counter can trivially achieve the effect of a reset by (locally) storing a snapshot and doing a subtract. Conversely, if the counter is truly reset, information is lost permanently.
-- 
/Jonathan Lundell.
