Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751830AbWIGSgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbWIGSgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbWIGSgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:36:02 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:37314 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161022AbWIGSER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:04:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=D8B+99l0YRUbeApwpCzDwVXBmdUALOPp4IwJTlTs5UqQyjTVbgImTfGL6i+IrfQ45t2J6Uvc0hWQBOFoajfu70HhK6vq2zk9ylJCfSV0uH5yEfIMx8CDZ2DO8ISPBvmvyvwKXDdedlGASN1BCwXWCPxHRorboDpYrSuYUfopr2c=
Message-ID: <1b270aae0609071104i5864dd7dtf268f639fc1ad5b7@mail.gmail.com>
Date: Thu, 7 Sep 2006 20:04:16 +0200
From: "Metathronius Galabant" <m.galabant@googlemail.com>
To: linux-kernel@vger.kernel.org
Subject: top displaying 50% si time and 50% idle on idle machine
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kernel 2.6.17.11 with tg3 network driver, NAPI enabled (Distro CentOS 4.4).
top shows strangely 50% idle even if the machine is _completely_ idle.

top - 01:04:30 up 4 days, 12:05,  2 users,  load average: 0.00, 0.00, 0.00
Tasks:  34 total,   2 running,  32 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0% us,  0.0% sy,  0.0% ni, 50.0% id,  0.0% wa,  0.0% hi, 50.0% si
Mem:   3634452k total,   313284k used,  3321168k free,    71308k buffers
Swap:   505896k total,        0k used,   505896k free,   220272k cached

I find this pretty alarming - can somebody please enlighten me?
Please include me on CC.
Thanks,
M.


/proc/stat:

cpu  9328 0 1749 19452596 2072 0 19466317 0
cpu0 9328 0 1749 19452596 2072 0 19466317 0
intr 39311864 38932062 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
58911 320891 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 1748303
btime 1157367528
processes 15115
procs_running 1
procs_blocked 0
