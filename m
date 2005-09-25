Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVIYWfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVIYWfJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 18:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVIYWfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 18:35:09 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:30103 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932344AbVIYWfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 18:35:07 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Subject: Re: Linux NTFS Vista compatibility (was: Re: [2.6-GIT] NTFS: Release 2.1.24.)
Date: Sun, 25 Sep 2005 23:35:37 +0100
User-Agent: KMail/1.8.91
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
References: <Pine.LNX.4.21.0509252047090.21817-100000@mlf.linux.rulez.org>
In-Reply-To: <Pine.LNX.4.21.0509252047090.21817-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509252335.37780.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 September 2005 20:12, Szakacsits Szabolcs wrote:
> On Sat, 10 Sep 2005, Anton Altaparmakov wrote:
> > On Sat, 10 Sep 2005, Alistair John Strachan wrote:
> > > Do these changes allow us to mount an NTFS volume created by Windows
> > > Vista/Longhorn beta 1 yet?
>
> So far the current NTFS code worked fine with Longhorn/Vista releases.
> WinFS and TxFS (transactional NTFS) are on top of current NTFS and MS
> engineers claim that they work hard to avoid on-disk NTFS format changes.
>
> > > I tried the driver in 2.6.13, and it complains about these
> > > $LogFile states, and ntfscp refuses to work.
>
> This happens probably due to the recent, strict $LogFile check changes.
> Several people reported these and Anton is investigating it.
>
> > > If you're unaware of the problem, I'm happy to help debug it.
>
> Anybody [keep] confirming that the current Linux NTFS code still works
> on the latest Vista beta releases would be highly encouraging for all
> of us ;)
>
> > I am indeed unaware of the problem.  Could you try the latest kernel
> > with the ntfs patches in it (Linus already merged them in the official
> > git tree) and tell me if it now works?  Thanks a lot in advance!
>
> Alistair, any result?
>
> > Note you will need to try the ntfs driver itself and not ntfscp as
> > libntfs does not have these changes yet hence ntfscp will not work just
> > the same (it does not use the kernel driver at all, it only uses
> > libntfs).
>
> The latest ntfsprogs CVS has also these changes and every tool should work
> fine with Vista (ntfscp, ntfsresize, ntfsundelete, ntfsclone, etc).

I have limited access to the beta, as it expires every 30 days and forces me 
to reinstall it. I promise to get back to all of you after 2.6.14 is released 
with the LogFile changes.

To clarify, I did not leave the Vista NTFS volume in an inconsistent state. I 
even forced a chkdsk, rebooted, let it run through, then attempted again to 
mount it with the NTFS code in 2.6.13. This categorically fails.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
