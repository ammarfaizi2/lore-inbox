Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVIHMOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVIHMOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 08:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVIHMOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 08:14:45 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:33062 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932482AbVIHMOp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 08:14:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=njiVI6Md67p2m4NxS19Fk9cvT7xpEcVw7P7mbQuUTt9CEIQdTXyg8DbtrjsC3867oWAN4ODbbOU05LFl/8pu0KyPipYoG7yBFCYUhpn9oonSpLotGcRwksRRwlSlPsEJkBoUA8UNoLFLeQ3OePeOuAb8zDBlmAsIGkAu8KAQ7BU=
Message-ID: <6bffcb0e050908051412e945c9@mail.gmail.com>
Date: Thu, 8 Sep 2005 14:14:39 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: michal.k.k.piotrowski@gmail.com
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.13-git7 strange system freeze
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after about 20 hours of uptime, my 2.6.13-git7 system freeze. I find
it in my klog.

Sep  8 13:45:09 ng02 kernel: KERNEL: assertion ((int)tp->lost_out >=
0) failed at net/ipv4/tcp_input.c (2148)
Sep  8 13:45:09 ng02 kernel: Leak l=4294967295 4
Sep  8 13:45:20 ng02 kernel: KERNEL: assertion ((int)tp->sacked_out >=
0) failed at net/ipv4/tcp_input.c (2147)
Sep  8 13:45:20 ng02 kernel: Leak s=4294967295 4
Sep  8 13:46:21 ng02 kernel: retrans_out leaked.
Sep  8 13:48:37 ng02 kernel: KERNEL: assertion ((int)tp->sacked_out >=
0) failed at net/ipv4/tcp_input.c (2147)
Sep  8 13:49:08 ng02 last message repeated 2 times
Sep  8 13:49:41 ng02 last message repeated 3 times
Sep  8 13:49:41 ng02 kernel: Leak s=4294967295 3
Sep  8 13:49:46 ng02 kernel: KERNEL: assertion ((int)tp->sacked_out >=
0) failed at net/ipv4/tcp_input.c (2147)
Sep  8 13:49:46 ng02 kernel: Leak l=1 4
Sep  8 13:49:46 ng02 kernel: Leak s=4294967295 4
Sep  8 13:49:52 ng02 kernel: KERNEL: assertion ((int)tp->sacked_out >=
0) failed at net/ipv4/tcp_input.c (2147)
Sep  8 13:49:52 ng02 kernel: KERNEL: assertion ((int)tp->sacked_out >=
0) failed at net/ipv4/tcp_input.c (2147)
Sep  8 13:49:52 ng02 kernel: Leak l=1 4
Sep  8 13:49:52 ng02 kernel: Leak s=4294967295 4
Sep  8 13:49:52 ng02 kernel: Leak r=1 4
Sep  8 13:49:58 ng02 kernel: KERNEL: assertion ((int)tp->sacked_out >=
0) failed at net/ipv4/tcp_input.c (2147)

Regards,
Michal Piotrowski
