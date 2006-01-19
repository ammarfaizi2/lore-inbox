Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbWASANa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWASANa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbWASAN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:13:29 -0500
Received: from mail.suse.de ([195.135.220.2]:10640 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161068AbWASAN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:13:29 -0500
From: Neil Brown <neilb@suse.de>
To: Cynbe ru Taren <cynbe@muq.org>
Date: Thu, 19 Jan 2006 11:13:23 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17358.55715.446269.276993@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
In-Reply-To: message from Cynbe ru Taren on Tuesday January 17
References: <E1EywcM-0004Oz-IE@laurel.muq.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 17, cynbe@muq.org wrote:
> 
> Just in case the RAID5 maintainers aren't aware of it:

Others have replied, but just so that you know that the "RAID5
maintainer" is listening, I will too.

You refer to "current" implementation and then talk about " a variety
of 2.4 and 2.6" releases.... Not all of them are 'current'.

The 'current' raid5 (in 2.6.15) is much more resilient against read
errors than earlier versions.

If you are having transient errors that really are very transient,
then the device driver should be retrying more I expect.

If you are having random connectivity error causing transient errors,
then your hardware is too unreliable for raid5 to code with.

As has been said, there *is* a supported way to regain a raid5 after
connectivity problems - mdadm --assemble --force.

The best way to help with the improvement of md/raid5 is to give
precise details of situations where md/raid5 doesn't live up to your
expectations.  Without precise details it is hard to make progress.

Thankyou for your interest.

NeilBrown
