Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTFPS0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTFPS0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:26:53 -0400
Received: from westhill.hyglo.com ([62.119.43.37]:47558 "EHLO
	westhill.hyglo.com") by vger.kernel.org with ESMTP id S264126AbTFPSZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:25:50 -0400
Message-ID: <3EEE0EEA.9080208@hyglo.com>
Date: Mon, 16 Jun 2003 20:39:38 +0200
From: Peter Enderborg <pme@hyglo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: vmware strange scheduling priority
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jun 2003 18:39:42.0917 (UTC) FILETIME=[A6E15750:01C33436]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Im playing with vmware 4.0 workstation. And it do some strange things.
I start vmware with nice and I got this:
26499 pme       19  19 95980  93M 95020 R N    12 32.6 24.8   8:55 
vmware-vmx
26439 pme       19  19  8416 8008  7692 R N     8  3.2  2.0   2:02 
vmware-vmx
26492 pme        6 -10 95980  93M 95020 R <    12  2.6 24.8   0:34 
vmware-vmx
26409 pme       19  19  4900 3916  2484 S N     0  1.0  1.0   0:29 vmware
26433 pme        5 -10  8416 8008  7692 S <     8  0.5  2.0   0:29 
vmware-vmx
26493 pme        5 -10  8056 7268  6988 S <     0  0.5  1.8   0:20 
vmware-mks
26495 pme        9   0 67672  65M 66888 S       0  0.2 17.4   0:11 
vmware-vmx


It have changed the prioority to -10 for some of its own tasks. How can 
that be done? Its a non suid binary started
by a normal user. It's very ugly, but Im more intressted in how it can 
be done.
The kernel is a 2.4.20.

