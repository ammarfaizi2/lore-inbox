Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277532AbRJJXf7>; Wed, 10 Oct 2001 19:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277530AbRJJXfu>; Wed, 10 Oct 2001 19:35:50 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:60176 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S277532AbRJJXfe>; Wed, 10 Oct 2001 19:35:34 -0400
Date: Thu, 11 Oct 2001 00:36:02 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]Fix bug:rmdir could remove current working directory
Message-ID: <20011011003602.B84467@compsoc.man.ac.uk>
In-Reply-To: <3BC4E8AD.72F175E3@us.ibm.com> <Pine.GSO.4.33.0110101816320.22872-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0110101816320.22872-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 06:21:01PM -0400, Ricky Beam wrote:

> On Wed, 10 Oct 2001, Mingming cao wrote:
> >I read the man page of
> >rmdir(2).  It says in this case EBUSY error should be returned.  I
> >suspected this is a bug and added a check in vfs_rmdir(). The following
> >patch is against 2.4.10 and has been verified.  Please comment and
> >apply.
> 
> The bug is in the manpage.  This was discussed over a year ago (some time

Well, the manpage only states what certain error nr. returns may mean, not what
will be returned when. Do you have an improvement on :

       EBUSY  pathname is the current working directory or root directory of some process.

regards
john

-- 
"Beware of bugs in the above code; I have only proved it correct, not tried
it."
	- Donald Knuth
