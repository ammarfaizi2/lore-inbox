Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263215AbUEBTyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbUEBTyT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 15:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbUEBTyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 15:54:18 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:27407 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263215AbUEBTx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 15:53:58 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Filesystem with multiple mount-points
Date: Sun, 2 May 2004 22:53:41 +0300
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.44.0405021508210.834-100000@poirot.grange>
In-Reply-To: <Pine.LNX.4.44.0405021508210.834-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405022253.41850.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 May 2004 16:24, Guennadi Liakhovetski wrote:
> Hi
>
> Disclaimer: I am not a filesystem expert, so, what's below might be
> absolute nonsense.
>
> There are systems, where it is desirable to make some partitions,
> possibly, including root, read-only, and some other, like, e.g., /var,
> /home, /lib/modules read-writable. Those writable filesystems may be quite
> small, so, putting them on separate partitions creates too much overhead
> for filesystem metadata, journals... Making those directories soft-links
> into one writable partition would work, but is not too nice.

I use softlinks. It works 100%. I can run unlimited number
of NFS mounted diskless workstations. All of them have
ro root fs, can mount /usr ro or rw as needed.
/var, /tmp, /etc are always writable.

I use mount --bind for only one mountpoint,
everuthing else is handled by softlinks.

Why do you think it is not too nice?
--
vda

