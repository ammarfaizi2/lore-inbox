Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUDHVjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 17:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUDHVjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 17:39:54 -0400
Received: from meyering.net1.nerim.net ([62.212.115.149]:1577 "EHLO
	elf.meyering.net") by vger.kernel.org with ESMTP id S262068AbUDHVjx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 17:39:53 -0400
To: Paul Eggert <eggert@CS.UCLA.EDU>
Cc: bug-coreutils@gnu.org, Andrew Morton <akpm@osdl.org>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-kernel@vger.kernel.org,
       Andy Isaacson <adi@hexapodia.org>
Subject: Re: dd patch to remove noctty
In-Reply-To: <87ekqyw79y.fsf_-_@penguin.cs.ucla.edu> (Paul Eggert's message of "Thu, 08 Apr 2004 13:20:57 -0700")
References: <Pine.GSO.4.21.0404071627530.9017-100000@dirac.phys.uwm.edu>
	<87r7uzlzz7.fsf@penguin.cs.ucla.edu> <87vfka30cm.fsf@ceramic.fifi.org>
	<87ekqyw79y.fsf_-_@penguin.cs.ucla.edu>
From: Jim Meyering <jim@meyering.net>
Date: Thu, 08 Apr 2004 23:40:23 +0200
Message-ID: <85d66iqhbs.fsf@pi.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Eggert <eggert@CS.UCLA.EDU> wrote:
> Philippe Troin <phil@fifi.org> writes:
>
>> noctty definitely seems overkill... I can't see why dd would ever want
>> to open a file without O_NOCTTY.
>
> Good point; it's just a confusion for the user.  Here's a patch to
> cause dd to always use O_NOCTTY.  If someone ever needs it the other
> way (not likely) I suppose we can add a "ctty" flag.
>
> 2004-04-08  Paul Eggert  <eggert@cs.ucla.edu>
>
> 	* NEWS: Remove noctty flag from dd.  Suggested by Philippe Troin.
> 	* doc/coreutils.texi (dd invocation): Likewise.
> 	* src/shred.c (O_NOCTTY): Remove redundant decl.
> 	* src/dd.c (flags, usage): Remove noctty flag.
> 	(main): Always use O_NOCTTY when opening files.

Applied.  Thanks!
