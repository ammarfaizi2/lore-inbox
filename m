Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUDHT7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUDHT7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:59:11 -0400
Received: from mirapoint1.TIS.CWRU.Edu ([129.22.104.46]:39433 "EHLO
	mirapoint1.tis.cwru.edu") by vger.kernel.org with ESMTP
	id S262462AbUDHTvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:51:18 -0400
To: Paul Eggert <eggert@CS.UCLA.EDU>
Cc: Jim Meyering <jim@meyering.net>, Andrew Morton <akpm@osdl.org>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>, bug-coreutils@gnu.org,
       linux-kernel@vger.kernel.org, Andy Isaacson <adi@hexapodia.org>
Subject: Re: dd PATCH: add conv=direct
In-Reply-To: <87vfkaw9i9.fsf@penguin.cs.ucla.edu> (Paul Eggert's message of
 "Thu, 08 Apr 2004 12:32:46 -0700")
References: <Pine.GSO.4.21.0404071627530.9017-100000@dirac.phys.uwm.edu>
	<87r7uzlzz7.fsf@penguin.cs.ucla.edu> <85k70qsp71.fsf@pi.meyering.net>
	<87vfkaw9i9.fsf@penguin.cs.ucla.edu>
From: prj@po.cwru.edu (Paul Jarc)
Organization: What did you have in mind?  A short, blunt, human pyramid?
Mail-Copies-To: nobody
Mail-Followup-To: Paul Eggert <eggert@CS.UCLA.EDU>, Jim Meyering
 <jim@meyering.net>,  Andrew Morton <akpm@osdl.org>, Bruce Allen
 <ballen@gravity.phys.uwm.edu>,  bug-coreutils@gnu.org,
 linux-kernel@vger.kernel.org,  Andy Isaacson <adi@hexapodia.org>
Date: Thu, 08 Apr 2004 15:51:11 -0400
Message-ID: <m3ad1mckoq.fsf@multivac.cwru.edu>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Eggert <eggert@CS.UCLA.EDU> wrote:
> Jim Meyering <jim@meyering.net> writes:
>> 2004-04-08  Jim Meyering  <jim@meyering.net>
>>
>> 	* src/dd.c (set_fd_flags): Don't OR in -1 when fcntl fails.
>
> Doesn't that fix generate worse code in the usual case, since it
> causes two conditional branches instead of one?

I think it's unnecessary anyway - if old_flags is -1, then the
conditional jumps to error() before looking at new_flags at all.


paul
