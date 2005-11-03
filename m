Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbVKCWaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbVKCWaP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVKCWaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:30:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:25991 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751410AbVKCWaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:30:12 -0500
Subject: Re: [PATCH 12/12: eCryptfs] Crypto functions
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Michael Thompson <michael.craig.thompson@gmail.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
In-Reply-To: <afcef88a0511031425u1fa5838fic86cbd7a341cb0a6@mail.gmail.com>
References: <20051103033220.GD2772@sshock.rn.byu.edu>
	 <20051103035659.GL3005@sshock.rn.byu.edu>
	 <1131055610.9365.17.camel@kleikamp.austin.ibm.com>
	 <afcef88a0511031425u1fa5838fic86cbd7a341cb0a6@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 16:30:09 -0600
Message-Id: <1131057009.9365.21.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 16:25 -0600, Michael Thompson wrote:
> On 11/3/05, Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> > On Wed, 2005-11-02 at 20:56 -0700, Phillip Hellewell wrote:
> > > +       ecryptfs_fput(lower_file);
> >
> > Why the call to ecryptfs_fput() here?  The caller does it's own fput on
> > lower_file.
> 
> Hmm, good catch. That slipped through us - and to be hoenst, I have no
> explination other than, it's wrong. ecryptfs_write_headers should not
> be responsible for put'ing that which it did not get.
> 
> I'm wondering if I should be sending 1 patch per tiny fix like this,
> or if I should be waiting for a few more changes, so as to not flood
> the threads with minor patches?

Well, I found it trying to look for the cause of bug 1228303, but I
haven't actually run anything to verify it.  It may be worth checking if
it fixes that problem, and if it does, it would bump up its importance.

> Thanks,
> Mike
> 
-- 
David Kleikamp
IBM Linux Technology Center

