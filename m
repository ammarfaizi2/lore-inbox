Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTEQIyK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 04:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTEQIyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 04:54:10 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:57844 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261308AbTEQIyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 04:54:09 -0400
From: Eugene Weiss <eweiss@sbcglobal.net>
Reply-To: eweiss@sbcglobal.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] submount: another removeable media handler
Date: Sat, 17 May 2003 02:05:00 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305170205.00407.eweiss@sbcglobal.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > how is it different from what automounter does?
> 
>>Autofs works by creating a special filesystem above the vfs layer, and 
passing 
>> requests and data back and forth.   Submount actually does much less than 
>> this- it puts a special filesystem underneath the real one, and the only 
>> things it returns to the VFS layer are error messages.  It handles no IO 
>>operations whatsoever.
>> 
>>Peter Anvin has called using the automounter for removeable media "abuse."
>> Submount is designed for it.
>> 

>Sure, but it's not clear to me that you have listened to me saying
>*why* it is abuse.

>Basically, in my opinion removable media should be handled by insert
>and removal detection, not by access detection.  Obviously, there are
>some sticky issues with that in the case where media can be removed
>without notice (like PC floppies or other manual-eject devices), but
>overall I think that is the correct approach.
>
>	-hpa

I managed to read several of your warnings about using autofs for media 
without coming across an explanation of why.  I just assumed that as 
maintainer, you had good reasons to do so.  I more-or-less agree with you 
about the desirability of insert and removal detection.  I'm not sure if it 
could ever be made to work for floppies, but there is no reason why one 
solution should fit all cases.  If there were common ioctls which could check 
the insertion and removal status of the various drives, I might have taken 
that approach.  

I wanted to get the same functionality as supermount without the instability, 
and as far as I can tell, I have succeeded.  It's not ideal, but it works for 
me, and hopefully will work for others as well until something better is 
produced.

Eugene
