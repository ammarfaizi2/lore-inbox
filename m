Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUDHRIG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbUDHRIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:08:06 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33965
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262060AbUDHRIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:08:01 -0400
Date: Thu, 8 Apr 2004 19:07:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-aa5
Message-ID: <20040408170759.GI31667@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-aa5.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-aa5/

Changelog diff between 2.6.5-aa4 and 2.6.5-aa5:

Only in 2.6.5-aa5: nonlinear-can-do-mlock

	Avoid truncate vs nonlinear BUG mentioned by Hugh Dickins on l-k.
	Give nonlinear only to privilegied users that knows how to avoid
	breaking the kernel. If local security doesn't matter disable-cap-mlock
	can be enabled and it'll give mlock and remap-file-pages too to every
	user. truncate must be fixed anyways to increase the strength of
	disable-cap-mlock but it gets low priority after moving the thing under
	sysctl, and I plan to keep the nonlinear hack forever under the sysctl
	for VM robusteness in providing _fair_ swapping to all processes.
	BTW, the mmap(MAP_POPULATE) API is horrible, there's no way to catch
	a failure with it, it doesn't return any retval, and I cannot fix it
	in my tree or I become ABI/API incompatible with linux 2.6, that's just
	a broken API that wants to be fixed properly in mainline despite the
	break of backwards compatibility.
