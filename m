Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbSJHWI3>; Tue, 8 Oct 2002 18:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSJHWI2>; Tue, 8 Oct 2002 18:08:28 -0400
Received: from smtpout.mac.com ([204.179.120.89]:6865 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S261402AbSJHWI1>;
	Tue, 8 Oct 2002 18:08:27 -0400
Message-ID: <3DA3589A.ED470EC5@mac.com>
Date: Wed, 09 Oct 2002 00:13:46 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
Organization: B16
X-Mailer: Mozilla 4.79 [de] (X11; U; Linux 2.4.18-4GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, pthreads-devel@www-124.southbury.usf.ibm.com
Subject: 2.5.40+ futex broken with COW
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The COW changes break PROCESS_SHARED futexes in
mmap( MAP_SHARED ).

I think that COW is unconditionally used on fork().
But you need to check for MAP_SHARED, eh?

If wanted I can provide a testcase (that runs fine on
2.4.19+futex patch + NGPT and on Irix)
