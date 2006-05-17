Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWEQNe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWEQNe6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWEQNe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:34:58 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:2259 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750828AbWEQNe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:34:58 -0400
Date: Wed, 17 May 2006 09:34:56 -0400
To: George Nychis <gnychis@cmu.edu>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       linux-lvm@redhat.com
Subject: Re: need help booting from SATA in 2.4.32
Message-ID: <20060517133456.GD23933@csclub.uwaterloo.ca>
References: <446A36B8.1060707@cmu.edu> <20060516203917.GQ11191@w.ods.org> <446A418E.3070307@cmu.edu> <20060517034814.GA25818@w.ods.org> <446B2523.1040800@cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446B2523.1040800@cmu.edu>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 09:29:07AM -0400, George Nychis wrote:
> Good suggestion on disabling IDE, it does not show up as SATA, it simply
> doesn't show up... after some googling, it seems as though no one has
> gotten it as SATA in 2.4:
> http://wip.powerblogs.com/posts/1124302626.shtml
> http://www.linuxquestions.org/questions/showthread.php?t=400521
> 
> Ok so, lets just assume we can't get SATA, and lets just try to get it
> to boot as /dev/hda ... so now i know nothing about LVM, can anyone
> provide me any insight on how to get this to boot with LVM?
> 
> So in 2.6.9, it loads VolGroup00/LogVol00 from /dev/sda5 which shows up
> in fdisk as LVM.  How can i get this to load from /dev/hda5 instead?

You don't.  SATA is using scsi style interface now, and with Alan Cox's
current work, IDE drives soon will too.  It will all go through libata
and show up as scsi disks.

It will be nice to have everything nice and consistent (except for the
few oddball raid cards that insist on being completely different) for
accessing disks.

SATA is not IDE, so why expect it to show up as an old style IDE disk?

Len Sorensen
