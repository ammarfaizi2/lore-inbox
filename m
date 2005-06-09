Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVFIGEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVFIGEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 02:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVFIGEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 02:04:10 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:27577 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261586AbVFIGEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 02:04:07 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>, jketreno@linux.intel.com
Subject: Re: ipw2100: firmware problem
Date: Thu, 9 Jun 2005 09:03:49 +0300
User-Agent: KMail/1.5.4
Cc: pavel@ucw.cz, jgarzik@pobox.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, ipw2100-admin@linux.intel.com
References: <20050608142310.GA2339@elf.ucw.cz> <42A7268D.9020402@linux.intel.com> <20050608.124332.85408883.davem@davemloft.net>
In-Reply-To: <20050608.124332.85408883.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506090903.49295.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 22:43, David S. Miller wrote:
> From: James Ketrenos <jketreno@linux.intel.com>
> Date: Wed, 08 Jun 2005 12:10:37 -0500
> 
> > My approach is to make the driver so it supports as many usage models as
> > possible, leaving policy to other components of the system.
> 
> I don't see how this kind of firmware load setup handles something
> like an NFS root over such a device that requires firmware.

You practically cannot avoid having initrd because you are very likely
to need to do some wifi config (at least ESSID and mode).
Well, you can, but it gets more arcane with each turn
(essid=,mode= module parameters - in each and every wifi driver!
and what if you need to set basic rates? Yet another parameter?).

It's analogous to DHCP+NFS_root boot - we do have ugly hack
of kernelspace dhcp client, but IIRC it is agreed that the Right Thing
is to do such things in userspace (if needed, via initrd/initramfs).

It simply allows for way more options what you can do in early boot
if you have early userspace.
--
vda

