Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276955AbRJCTOV>; Wed, 3 Oct 2001 15:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276954AbRJCTOM>; Wed, 3 Oct 2001 15:14:12 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:62898 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276956AbRJCTNy>; Wed, 3 Oct 2001 15:13:54 -0400
Subject: ftruncate
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Cc: ltp <ltp-list@lists.sourceforge.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 03 Oct 2001 14:19:11 +0000
Message-Id: <1002118765.12683.8.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One of the testcases we have in the Linux Test Project, ftruncate03,
does some negative testing for the ftruncate system call.  It has
previously passed, and even passes on 2.4.11-pre1, but I noticed today
that it does NOT pass on 2.4.10-ac4.  It looks like the problem is with
2.4.11-pre1 and the testcase though if my man pages are right.  The test
is looking to get EACCESS back when the file is opened read only and
ftruncate is called on it, but the man page says it should actually
return EINVAL.

A fixed version of this testcase will be in our next release.  I know
it's fairly trivial, but it would be nice to see this fix synced up with
Linus's tree.

Thanks,
Paul Larson

