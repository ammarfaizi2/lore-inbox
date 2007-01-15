Return-Path: <linux-kernel-owner+w=401wt.eu-S1751167AbXAOSRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbXAOSRV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 13:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbXAOSRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 13:17:21 -0500
Received: from hera.kernel.org ([140.211.167.34]:40331 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbXAOSRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 13:17:20 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: incorrect TCP checksum on sent TCP-MD5 packets (2.6.20-rc5)
Date: Mon, 15 Jan 2007 10:15:22 -0800
Organization: OSDL
Message-ID: <20070115101522.481e2f8f@freekitty>
References: <1168803154.3090.45.camel@elida.cbxnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1168884954 14029 10.8.0.54 (15 Jan 2007 18:15:54 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 15 Jan 2007 18:15:54 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2007 20:32:34 +0100
Torsten Luettgert <t.luettgert@pressestimmen.de> wrote:

> Hi,
> 
> I'm using the new TCP-MD5 option in 2.6.20-rc4 and rc5
> to talk BGP to cisco routers.
> My box connects to the cisco, and the handshake looks fine:
> SYN, SYN/ACK, ACK all have md5 option and correct TCP checksums.
> 
> All packets after that, i.e. the ones with payload data,
> have wrong TCP checksums, quoth wireshark.
> The same happens if the cisco connects: the first, "empty" packet
> is ok, packets with payload aren't.
> 
> Am I doing something wrong? Or is this a bug?
> 
> I'll gladly send tcpdumps if it helps.
> 
> Thanks for your help,
> Torsten

Are you running over a device that does checksum offload?


-- 
Stephen Hemminger <shemminger@osdl.org>
