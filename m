Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269394AbUJSU4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269394AbUJSU4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 16:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269896AbUJSUtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 16:49:07 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:56334 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269693AbUJSUqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 16:46:23 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: alistair@devzero.co.uk, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9: performance issues on Via Epia
Date: Tue, 19 Oct 2004 23:46:14 +0300
User-Agent: KMail/1.5.4
References: <200410191604.22747.alistair@devzero.co.uk>
In-Reply-To: <200410191604.22747.alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410192346.14695.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 October 2004 18:04, Alistair John Strachan wrote:
> Hi,
> 
> I recently upgraded from 2.6.8.1 to 2.6.9 (the release, not -final) on my Via 
> Epia 5000 router. Now when I transfer files from the machine's HD vsftpd can 
> only achieve 3MB/s.

> I believe this is some performance problem specifically related to XFS, or 
> something specific to the local VM, because if I transfer from an NFS mounted 
> directory on the same machine, vsftpd easily achieves the 10MB/s I'm used to.

Sound like 'DMA off' problem.
 
> Top shows something typical to this during transfers from the machine's local 
> HD;
> 
> Cpu(s):  0.7% us,  9.2% sy,  0.0% ni,  0.3% id, 84.5% wa,  5.3% hi,  0.0% si
> 
> Which seems like an awful lot of wait time. Anybody got any suggestions of 
> where to start reverting patches? The amount of difference between 2.6.8.1 
> and 2.6.9 is quite daunting.

Binary search is converging quickly.
 
> By the way, copying a file locally on the system from the same partition to 
> another directory is far more efficient.
> 
> [root] 16:02 [~] time cp /var/cache/swapfile here
> `/var/cache/swapfile' -> `here'
> 
> real    0m37.904s
> user    0m0.115s
> sys     0m13.033s

size of this file?

