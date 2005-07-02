Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVGBJMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVGBJMu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 05:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVGBJMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 05:12:50 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:58277 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261831AbVGBJMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 05:12:46 -0400
Message-ID: <42C65A8B.9060705@gentoo.org>
Date: Sat, 02 Jul 2005 10:12:43 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: =?UTF-8?B?RGF2aWQgR8OzbWV6?= <david@pleyades.net>,
       Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy> <20050630193320.GA1136@fargo> <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk> <20050630204832.GA3854@fargo> <Pine.LNX.4.60.0506302158190.29755@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0506302158190.29755@hermes-1.csi.cam.ac.uk>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

I'm trying to work around the NTFS lockup issue. Like others, I can reproduce
it just by opening nautilus on an NTFS partition (i.e. creating an inotify
watch on it) and then unmount at some point after - instant system lockup.

I have tried applying two patches:
fix-soft-lockup-due-to-ntfs-vfs-part-and-explanation.patch from 2.6.13-rc1-mm1
and the "NTFS: Fix a nasty deadlock that appeared in recent kernels" patch
from your git tree.

However, I still get the freezing up on unmount. I am using 2.6.12, plus
inotify-0.23-15, and the two patches mentioned above. Anything else I can try?

Thanks,
Daniel
