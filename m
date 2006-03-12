Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWCLJ2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWCLJ2O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 04:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWCLJ2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 04:28:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21458 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751291AbWCLJ2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 04:28:12 -0500
Subject: Re: Re[8]: problems with scsi_transport_fc and qla2xxx
From: Arjan van de Ven <arjan@infradead.org>
Reply-To: arjan@infradead.org
To: Maxim Kozover <maximkoz@netvision.net.il>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Vasquez <andrew.vasquez@qlogic.com>
In-Reply-To: <1699632492.20060312001014@netvision.net.il>
References: <1119462161.20060306230951@netvision.net.il>
	 <20060306212835.GO6278@andrew-vasquezs-powerbook-g4-15.local>
	 <1229893529.20060307000953@netvision.net.il>
	 <20060306232831.GS6278@andrew-vasquezs-powerbook-g4-15.local>
	 <1219491790.20060307124035@netvision.net.il>
	 <20060307172227.GE6275@andrew-vasquezs-powerbook-g4-15.local>
	 <1343850424.20060307231141@netvision.net.il>
	 <20060308080050.GF9956@andrew-vasquezs-powerbook-g4-15.local>
	 <20060308154341.GA1779@andrew-vasquezs-powerbook-g4-15.local>
	 <1502511597.20060308213247@netvision.net.il>
	 <20060310231344.GB641@andrew-vasquezs-powerbook-g4-15.local>
	 <1699632492.20060312001014@netvision.net.il>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 10:28:03 +0100
Message-Id: <1142155684.2882.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 00:10 +0300, Maxim Kozover wrote:
> Hi Andrew!
> Congratulations! The kernel from scsi-rc-fixes git and your patch are
> working.
> By the way, could you, please, tell me how I get only scsi patches
> from the git repository, cause I got the whole kernel by using
> cg-clone http://kernel.org/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git
> 
> Now the process looks like following:
> Mar 11 23:54:22 multipath kernel: qla2xxx 0000:03:01.0: LOOP DOWN detected (2).
> Mar 11 23:54:28 multipath kernel:  rport-4:0-0: blocked FC remote port time out:
>  removing target and saving binding
> Mar 11 23:54:37 multipath kernel: qla2xxx 0000:03:01.0: LIP reset occured (f7f7).
> Mar 11 23:54:37 multipath kernel: qla2xxx 0000:03:01.0: LOOP UP detected (2 Gbps).
> Mar 11 23:54:59 multipath kernel:  4:0:0:0: timing out command, waited 22s
> 
> And the disks appear.
> Could you tell me, please, where this 22sec timeout came from?

looks like your fiber fabric decided to renegotiate, and halfway it went
for a coffee and donuts break to not upset the union rules :)

I've seen LOOP negotiations take 10+ seconds before, and that is on a
really simple setup.... so nothing super special 

