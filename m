Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVDLLh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVDLLh1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVDLLfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:35:22 -0400
Received: from mail.aei.ca ([206.123.6.14]:55494 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262341AbVDLLcc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:32:32 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2-mm3
Date: Tue, 12 Apr 2005 07:32:24 -0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050411012532.58593bc1.akpm@osdl.org>
In-Reply-To: <20050411012532.58593bc1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504120732.24440.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 April 2005 04:25, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> 
> 
> - The anticipatory I/O scheduler has always been fairly useless with SCSI
> � disks which perform tagged command queueing. �There's a patch here from Jens
> � which is designed to fix that up by constraining the number of requests
> � which we'll leave pending in the device.
> 
> � The depth currently defaults to 1. �Tunable in
> � /sys/block/hdX/queue/iosched/queue_depth
> 
> � This patch hasn't been performance tested at all yet. �If you think it is
> � misbehaving (the usual symptom is processes stuck in D state) then please
> � report it, then boot with `elevator=cfq' or `elevator=deadline' to work
> � around it.
> 
> - More CPU scheduler work. �I hope someone is testing this stuff.

Something is not quite right here.  I built rc2-mm3 and booted (uni processor, amd64, preempt on).  
mm3 lasted about 30 mins before locking up with a dead keyboard.  I had mm2 reboot a few times
over the last couple of days too.  

11-mm3 uptime of 2 weeks+
12-rc2-mm2 reboots once every couple of days
12-rc2-mm3 locked up within 30 mins using X using kmail/bogofilter

My serial console does not seem to want to work.  Has anything changed with this support?

TIA,
Ed Tomlinson

