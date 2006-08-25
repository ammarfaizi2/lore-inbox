Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422652AbWHYST4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbWHYST4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbWHYST4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:19:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:11071 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422652AbWHYSTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:19:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rmfoOE7BhqZbJ9z1AlQdnTBUotcpvb6uJ/hDINiBcRQRDiRYC/de/lOZxFEbYZrTupFf6s1sJqGOdWVM1NHFdogvXG5SgsKRshY6+0v/q7riiVyu4dRI1Rx2U4gznjFINBFVItFBNRam2wwG5ks8d+7WOELA5/gPuc9s1H7BzCI=
Message-ID: <87f94c370608251119j4e04b33at67e86539b7bd1744@mail.gmail.com>
Date: Fri, 25 Aug 2006 14:19:53 -0400
From: "Greg Freemyer" <greg.freemyer@gmail.com>
To: "Aleksey Gorelov" <dared1st@yahoo.com>
Subject: Re: Generic Disk Driver in Linux
Cc: "Helge Hafting" <helge.hafting@aitel.hist.no>, jengelh@linux01.gwdg.de,
       daniel.rodrick@gmail.com, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org, linux-newbie@vger.kernel.org,
       satinder.jeet@gmail.com
In-Reply-To: <20060825170513.60108.qmail@web83113.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44EECF16.6060602@aitel.hist.no>
	 <20060825170513.60108.qmail@web83113.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/06, Aleksey Gorelov <dared1st@yahoo.com> wrote:
>
>
> --- Helge Hafting <helge.hafting@aitel.hist.no> wrote:
>
> > Aleksey Gorelov wrote:
> > >> From: linux-kernel-owner@vger.kernel.org
> > >> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jan Engelhardt
> > >>
> > >>> I was curious that can we develop a generic disk driver that could
> > >>> handle all the kinds of hard drives - IDE, SCSI, RAID et al?
> > >>>
> > >> ide_generic
> > >> sd_mod
> > >>
> > >> All there, what more do you want?
> > >>
> > >
> > > Unfortunately, not _all_. DMRAID does not support all fake raids yet. Moreover, there is
> > usually
> > > some gap for bleeding edge hw support.
> > >
> > Nobody will want to use bleeding edge hardware with an int13 driver,
> > because the performance will necessarily be much worse than using more
> > moderate hardware with the generic IDE driver.
> If some one wants Linux server - I totally agree. I would probably even avoid relying purely on
> generic IDE and instead use chipset specific variant or libata.
> But if someone wants to access already installed & working other OS stuff - that's a different
> story. Bad performance is still better than no support at all.
>

I'll add a vote for this.  Not sure if the user base is large enough
to justify it being added to the mainline kernel, but Computer
Forensic professionals often need to image computers with Raid setups.
 (image == dd copy of logical volume)

For many configurations, the current choices are sub-optimal.  It
would be nice to have a boot disk that could capture any and all raid
volumes.

FYI: There are already many linux boot CDs that specifically target
Computer Forensics tasks, so there is a bigger user community than
many might assume.  Examples incude SPADA (law enforcement only),
smart, Farmer Dude's boot cd, FCCU GNU/Linux Forensic Boot CD, Helix,
Penguin Sleuth.

All of the above would benefit from a generic, but slow raid driver.
For this use it would be great if both real raid and fake raid were
supported.  Not sure if fake raid comes with int13 support or not.

Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
