Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUFQT7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUFQT7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUFQT7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:59:24 -0400
Received: from meetpoint.leesburg-geeks.org ([66.63.28.250]:2058 "EHLO
	meetpoint.home") by vger.kernel.org with ESMTP id S262008AbUFQT7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:59:17 -0400
Message-ID: <40D1F809.8030405@leesburg-geeks.org>
Date: Thu, 17 Jun 2004 15:59:05 -0400
From: Ken Ryan <linuxryan@leesburg-geeks.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Egger <degger@fhm.edu>
CC: Hans Reiser <reiser@namesys.com>, Timothy Miller <miller@techsource.com>,
       linux-kernel@vger.kernel.org, pla@morecom.no
Subject: Re: mode data=journal in ext3. Is it safe to use?
References: <40D1B110.7020409@leesburg-geeks.org> <40D1C18B.1030907@techsource.com> <40D1D2F0.7080102@namesys.com> <A5938B92-C096-11D8-AAF6-000A958E35DC@fhm.edu>
In-Reply-To: <A5938B92-C096-11D8-AAF6-000A958E35DC@fhm.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:

> On 17.06.2004, at 19:20, Hans Reiser wrote:
>
>> Actually, most compact flash devices DO do wear leveling, from what I 
>> have heard.
>
>
> Care to mention sources? I'd be surprised if they did simply because
> it'll cost money that could be earned otherwise. Also I think you
> confuse bad block remapping with wear leveling and even the former
> I haven't experienced so far.
>
> CF disks were designed for simply the reason of having an empty disk,
> writing data onto it up to a certain level, reading it a few times
> and emptying the disk again. So except for the organizational blocks
> and "the end" of a disk which tends to get rarely hit there're a
> well distributed write utilization.
>
> Servus,
>       Daniel


For example:

Just bop over to the Sandisk website, go the the OEM section, and download
the manual/datasheet for CF devices.  The wearlevel command itself isn't
supported (I'm ignorant of flash on IDE, I assume it is intended to mean
full scrub-style wear levelling) but they note they roll simplified wear 
levelling
into the erased page pool.

Doing that is an easy way to get part of the way there without needing a 
lot of
infrastructure.  And for the fill-read-empty usage model it's perfectly 
fine.

                ken


