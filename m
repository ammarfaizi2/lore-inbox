Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSLPU6U>; Mon, 16 Dec 2002 15:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSLPU6U>; Mon, 16 Dec 2002 15:58:20 -0500
Received: from ool-182f57bc.dyn.optonline.net ([24.47.87.188]:8363 "EHLO
	j0nah.ath.cx") by vger.kernel.org with ESMTP id <S261448AbSLPU6U>;
	Mon, 16 Dec 2002 15:58:20 -0500
Date: Mon, 16 Dec 2002 11:07:06 -0500
From: Jonah Sherman <jsherman@stuy.edu>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021216160706.GA18431@rootbox>
Reply-To: Jonah Sherman <jsherman@stuy.edu>
Mail-Followup-To: Mark Mielke <mark@mark.mielke.cc>,
	linux-kernel@vger.kernel.org
References: <20021215220132.GB6347@elf.ucw.cz> <200212160733.gBG7XhD67922@saturn.cs.uml.edu> <20021216111759.GA24196@atrey.karlin.mff.cuni.cz> <20021216175432.GA5094@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216175432.GA5094@mark.mielke.cc>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 12:54:32PM -0500, Mark Mielke wrote:
> Programs that self verify their own CRC may get a little confused (are
> there any of these left?), but other than that, 'goto is better avoided'
> as well, but sometimes 'goto' is the best answer.

This shouldn't cause any problems.  The only way this would cause a problem is if the program had direct system calls in it, but as long as they are using libc(what self-crcing program doesn't use libc?), the changes would only be made to code pages inside libc, so the program's own code pages would remain untouched.
