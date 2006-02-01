Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWBAMTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWBAMTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWBAMTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:19:21 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:48462 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932430AbWBAMTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:19:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=Kn7rify0yofoA4AVfXv1LqchLPVAUg/7+mVVLq7aJrgdQ3xhqvm7Vg+98rWaOjzarNjCk92YAQ1EWgSOu7suD7mOlZd4W1d39CoPD9MNKPYBkOJvWp7pWqR21AvYm3ALQ8/IKwh6Ubmql//VT8l4hHX2rEG3qwOphX33Xw5quQU=
Message-ID: <81083a450602010419l16e6c2f2ldf1f87bff2582662@mail.gmail.com>
Date: Wed, 1 Feb 2006 17:49:18 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, linux-net@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Subject: Re: [RFC] Poor Network Performance with e1000 on 2.6.14.3
In-Reply-To: <43E04712.6080108@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3046_27781836.1138796358412"
References: <81083a450601312117p391f1780g5bb25f5f90324f85@mail.gmail.com>
	 <43E04712.6080108@candelatech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3046_27781836.1138796358412
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 2/1/06, Ben Greear <greearb@candelatech.com> wrote:
> Ashutosh Naik wrote:
> > Now, I assume that on Gigabit ethernet, I should be getting Line Rate,
> > which is around 220 MBps. Even the CPU is not getting max-ed out here
> > and I am at a loss to understand this behaviour.
>
> Make sure you are running 64-bit 100+Mhz PCI, otherwise you will not
> get line speed.  ethtool -d [device]
> may get that info for you.

Thanks for that Ben. I now used a 64 bit,133 MHz PCI-X on both
machines and I got around  180 MBps, (86259.48 + 95164.90 ), which is
still a decent way away from Line speed. I think PCI is not a
bottleneck now, although I could be wrong. What could I be missing,
and has anybody seen line speed ( 220 MBps ) with e1000 ?

Regards and Thanks
Ashutosh

ps - Attaching my ettcp log

------=_Part_3046_27781836.1138796358412
Content-Type: text/plain; name=log.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="log.txt"

[root@localhost ~]# ettcp -s -t -i 300ttcp-r: accept from 192.168.90.100
User: 17553  Nice: 0  System 8885  Idle:737051  Params:4

ttcp-t: buflen=65536, nbuf=2048, align=16384/0, port=5001  tcp  -> 192.168.90.10
0
nttcp-t: socket
nttcp-t: connect
User: 17555  Nice: 0  System 8892  Idle:737076  Params:4
^[
User: 19818  Nice: 0  System 14716  Idle:747604  Params:4
User_diff: 2265  Nice_diff: 0  System_diff: 5831  Idle_diff:10553 Tot:18649
User: 12.145423  System: 31.267092  Nice 0.000000  Idle:56.587485        
nttcp-r: Buflen:65536 SysLoad:31.27% 29232070656 bytes 299.97secs =95164.90 KB/s
ec
nttcp-r: 699884 I/O calls, msec/call = 0.44, calls/sec = 2333.15
nttcp-r: 0.2user 32.6sys 4:59real 10% 0i+0d 0maxrss 0+30pf 691228+3947csw
User: 19834  Nice: 0  System 14722  Idle:747623  Params:4
User_diff: 2279  Nice_diff: 0  System_diff: 5830  Idle_diff:10547 Tot:18656
User: 12.215909  System: 31.250000  Nice 0.000000  Idle:56.534091        
nttcp-t: Buflen:65536 SysLoad:31.25% 26499153920 bytes 300.00secs =86259.48 KB/s
ec
nttcp-t: 404345 I/O calls, msec/call = 0.76, calls/sec = 1347.80
nttcp-t: 0.2user 44.9sys 5:00real 15% 0i+0d 0maxrss 0+30pf 374765+1306csw
[1]+  Done                    ettcp -s -r -l 65536





------=_Part_3046_27781836.1138796358412--
