Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbUAAWTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbUAAWTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:19:04 -0500
Received: from net4visions.de ([217.160.106.106]:2641 "EHLO
	smtp.net4visions.de") by vger.kernel.org with ESMTP id S264963AbUAAWRQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 17:17:16 -0500
Message-ID: <3FF49C5D.8050003@tower-net.de>
Date: Thu, 01 Jan 2004 23:17:01 +0100
From: Markus Kolb <usenet@tower-net.de>
Organization: tower networks
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: tcp socks at close_wait for days without process
References: <fa.elrs5lj.1n4inbv@ifi.uio.no> <fa.pbs8b1q.1i5g1g8@ifi.uio.no>
In-Reply-To: <fa.pbs8b1q.1i5g1g8@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.23.0.2; VDF: 6.23.0.22; host: mail.tower-net.all)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mihai RUSU wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Mon, 29 Dec 2003, Markus Kolb wrote:
[...]
> netstat -an | grep CLOSE_WAIT
> fuser -n tcp <localport>,<remote-addr>,<remote-port>
> where <localport>, <remote-addr>, <remote-port> you take them from the 
> netstat output. fuser should give you the PID of the owner of the sockets 
> in CLOSE_WAIT. kill it and they should dissapear.

Well the process list has been very short. So I am pretty sure that 
there hasn't been any processes from the application.
Could it be that the socket which first belongs to the crashed 
application is bound to the father process of this crashed application?
This would be a bash or init.

Thanks for the hint with fuser.
Before the next reboot I will try to reproduce and will use the fuser 
command to see more details.

Bye

