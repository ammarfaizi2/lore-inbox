Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266172AbRF2UQJ>; Fri, 29 Jun 2001 16:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266173AbRF2UP7>; Fri, 29 Jun 2001 16:15:59 -0400
Received: from [64.68.77.148] ([64.68.77.148]:8335 "EHLO mta05.onebox.com")
	by vger.kernel.org with ESMTP id <S266172AbRF2UPo>;
	Fri, 29 Jun 2001 16:15:44 -0400
Date: Fri, 29 Jun 2001 13:15:31 -0700
Subject: raid + xfs
Reply-To: jonathan.bright@onebox.com
From: "jonathan bright" <jonathan.bright@onebox.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1BoxPartBoundary99384573110413993845731"
Message-Id: <20010629201531.BNAU10107.mta05.onebox.com@onebox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--1BoxPartBoundary99384573110413993845731
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi.

i'm using xfs on top of raid, and have noticed some
unusual behavior.

my basic hardware configuration is 850 p3, intel d815eea2
motherboard, 4 ibm drives, 2 promise cards, and a separate
drive on built in ide channel as the root (this was not the
initial configuration, but kind of evolved as we went ahead.)

what we noticed was that the resyncing speed as reported by
cat /proc/mdstat was originally 100k/sec, making resyncing take
forever.  we bumped /proc/sys/dev/raid up, and got resyncing
to around 3000k/sec, with 90% cpu usage for raid5sync.

then i decided to run the bonnie benchmark, and *while*
bonnie was running, resyncing went up to 10000k, with low
CPU usage.  when bonnie finised, resyncing started to
behave badly again.  (and bonnie's performance wasn't noticably
impacted by the resyncing either).

perhaps in a few weeks i might be able to investigate the
raid code, but i'm hoping that someone might know what is
causing this behavior.

please CC me at jonathan.bright@onebox.com if you reply.

thanks,
jon bright

--
jonathan bright
jonathan.bright@onebox.com
415.820.7322 - voicemail/fax
www.brightconsulting.com

--1BoxPartBoundary99384573110413993845731
Content-type: application/octet-stream; charset=us-ascii
Content-Transfer-Encoding: base64
Content-Disposition: attachment

DQo=

--1BoxPartBoundary99384573110413993845731
Content-type: application/octet-stream; charset=us-ascii
Content-Transfer-Encoding: base64
Content-Disposition: attachment

DQo=

--1BoxPartBoundary99384573110413993845731
Content-type: application/octet-stream; charset=us-ascii
Content-Transfer-Encoding: base64
Content-Disposition: attachment

DQo=

--1BoxPartBoundary99384573110413993845731--
