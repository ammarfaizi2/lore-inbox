Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265654AbRF1MWC>; Thu, 28 Jun 2001 08:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265653AbRF1MVv>; Thu, 28 Jun 2001 08:21:51 -0400
Received: from smtp102.urscorp.com ([64.17.27.233]:3342 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S265648AbRF1MVg>; Thu, 28 Jun 2001 08:21:36 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OF95A43E53.39291B42-ON84256A79.003D421D@urscorp.com>
Date: Thu, 28 Jun 2001 09:20:09 -0300
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 06/28/2001 08:15:47 AM,
	Serialize complete at 06/28/2001 08:15:47 AM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If individual pages could be classified as code (text segments), 
> data, file cache, and so on, I would specify costs to the paging 
> of such pages in or out.  This way I can make the system perfer 
> to drop a file cache page that has not been accessed for five 
> minutes, over a program text page that has not been acccessed 
> for one hour (or much more).

This would be extremely useful. My laptop has 256mb of ram, but every day 
it runs the updatedb for locate. This fills the memory with the file 
cache. Interactivity is then terrible, and swap is unnecessarily used. On 
the laptop all this hard drive thrashing is bad news for battery life 
(plus the fact that laptop hard drives are not the fastest around). I 
purposely do not run more applications than can comfortably fit in the 
256mb of memory.

If fact, to get interactivity back, I've got a small 10 liner that mallocs 
memory to *force* stuff into swap purely so I can have a large block of 
memory back for interactivity.

Something simple that did "you haven't used this file for 30mins, flush it 
out of the cache would be sufficient"

Mike
