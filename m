Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbUDOQBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 12:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbUDOQBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 12:01:43 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:22361 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264093AbUDOQBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 12:01:42 -0400
Message-ID: <407EBFD3.7080705@myrealbox.com>
Date: Thu, 15 Apr 2004 10:01:07 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040415
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rg_Mensmann?= <joerg.mensmann@gmx.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-kernel] Via-Rhine ethernet driver problem?
References: <1F9GE-4iZ-31@gated-at.bofh.it> <m3pta9z1pw.fsf@msgid.bitplanet.de>
In-Reply-To: <m3pta9z1pw.fsf@msgid.bitplanet.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörg Mensmann wrote:
> Hi!
> 
> Did you find a solution for that problem? I think I'm currently fighting
> with the same issues.
> 
> walt <wa1ter@myrealbox.com> wrote:
>>ECS K7VTA3 motherboard with built-in ethernet chip:
>>The problem is terrible performance -- I noticed that NFS file transfers grind
>>to a complete halt almost immediately on this machine.

Roger Luethi (the maintainer) sent me this patch which works great for me:

--- via-rhine.c.orig	2004-04-12 19:27:41.000000000 +0200
+++ via-rhine.c	2004-04-14 19:09:29.860264907 +0200
@@ -834,6 +834,7 @@
  					netif_carrier_on(dev);
  				else
  					netif_carrier_off(dev);
+				break;
  			}
  		}
  		np->mii_cnt = phy_idx;
