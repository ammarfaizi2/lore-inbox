Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUDSWi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUDSWi1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 18:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbUDSWi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 18:38:27 -0400
Received: from ms-smtp-03-smtplb.ohiordc.rr.com ([65.24.5.137]:20911 "EHLO
	ms-smtp-03-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S262006AbUDSWiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 18:38:25 -0400
From: Rob Couto <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: Remi Colinet <remi.colinet@free.fr>
Subject: Re: Questions : disk partition re-reading
Date: Mon, 19 Apr 2004 18:37:55 -0400
User-Agent: KMail/1.6.1
References: <4082819E.10106@free.fr>
In-Reply-To: <4082819E.10106@free.fr>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404191837.55275.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 April 2004 09:24 am, you wrote:
> Hi,
>
> I have 2 questions about disk partitioning under linux 2.6.x :
>
> 1/ Is it possible to alter a disk partition of a used disk and beeing
> able to use the modified partition without having to reboot the box?
>

as already stated,it can be. fdisk tries to refresh the kernel's copy of the 
table every time it writes, and hdparm -Z /dev/hdx does the same, but both 
will fail if any partitions are mounted from that disk. unmounting, then 
re-partitioning, then remounting lets it work... this is often useful to me 
when working from rescue disks but never when booted from that drive, or 
if /usr, /var, or /tmp are on it

-- 
Rob Couto [rpc@cafe4111.org]
computer safety tip: use only a non-conducting, static-free hammer.
--
