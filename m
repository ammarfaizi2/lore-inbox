Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUDHQXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 12:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUDHQXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 12:23:40 -0400
Received: from tantale.fifi.org ([216.27.190.146]:41371 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261952AbUDHQXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 12:23:38 -0400
To: Paul Eggert <eggert@CS.UCLA.EDU>
Cc: bug-coreutils@gnu.org, Andy Isaacson <adi@hexapodia.org>,
       Andrew Morton <akpm@osdl.org>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
References: <Pine.GSO.4.21.0404071627530.9017-100000@dirac.phys.uwm.edu>
	<87r7uzlzz7.fsf@penguin.cs.ucla.edu>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 08 Apr 2004 09:23:21 -0700
In-Reply-To: <87r7uzlzz7.fsf@penguin.cs.ucla.edu>
Message-ID: <87vfka30cm.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Eggert <eggert@CS.UCLA.EDU> writes:

>   dd has new iflags= and oflags= options with the following flags:
> 
>     append    append mode (makes sense for output file only)
>     direct    use direct I/O for data
>     dsync     use synchronized I/O for data
>     sync      likewise, but also for metadata
>     nonblock  use non-blocking I/O
>     nofollow  do not follow symlinks
>     noctty    do not assign controlling terminal from file

noctty definitely seems overkill... I can't see why dd would ever want
to open a file without O_NOCTTY. On systems where O_NOCTTY makes sense
(SvR4) that is.

Phil.
