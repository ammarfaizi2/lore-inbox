Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbUCaQxS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUCaQxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:53:18 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:51208 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262077AbUCaQxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:53:16 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.25 vanilla on proliant
Date: Wed, 31 Mar 2004 18:53:06 +0200
User-Agent: KMail/1.5.4
References: <D9B4591FDBACD411B01E00508BB33C1B01E2575C@mesadm.epl.prov-liege.be>
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01E2575C@mesadm.epl.prov-liege.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403311853.06569.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 March 2004 15:26, Frederick, Fabian wrote:
> Hi,
>
> 	I'm trying to install a 2.4.25 on Advanced server 2.1 Proliant
> Compaq.
> 	I keep having the following :
> 		...
> 		ds:no socket drivers loaded
> 		kmod: failed to exec /sbin/modprobe -s -k block_major_104,
> errno=2
> 		VFS : cannot open root device "cciss/c0d0p6" or 68:06
> 		Please append a correct "root=" boot option
> 		kernel panic : VFS : unable to mount root fs on 68:06

104=0x68
kernel tries to load drivers for your root fs's underlying block device
but fails. Verify that initrd contains them or compile them in
non-modular.
--
vda

