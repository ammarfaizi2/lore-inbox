Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbTKSKGM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 05:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263920AbTKSKGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 05:06:12 -0500
Received: from 44ba20135.mrgnhll.ca.charter.com ([68.186.32.135]:34936 "EHLO
	uzo.telecoma.net") by vger.kernel.org with ESMTP id S263812AbTKSKGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 05:06:11 -0500
Date: Wed, 19 Nov 2003 02:25:42 -0800
From: Firenza <firenza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: time freeze under 2.4.9
Message-ID: <20031119022542.J777@telecoma.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Pretext: 4-way server runs on plain vanilla redhat 2.4.9-21
kernel for almost 2 years without any problems. Two weeks ago,
applications start to behave "strangely", which is traced 
back to the fact that time "froze" on that server.

# strace sleep 1
...
nanosleep({1, 0},  <unfinished ...> (never returns)

date shows the freezing time, hwclock shows that the hardware
clock is still working and no suspicious kernel messages are
found in the logs.

Discouragingly, the same thing happened to a different server
(same kernel, very similar hardware) a couple of days later.
Additionally that server is not in use, which makes it less
likely that this behaviour is caused by a freshly introduced
application.

Rebooting fixed the problem, but the same behaviour surfaced
again for the first server a couple of hours ago.

What circumstances could cause this behaviour? 

Is there a way to further pinpoint the cause?

cheers,
Firenza

