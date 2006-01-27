Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWA0KWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWA0KWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 05:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWA0KWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 05:22:10 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:3250 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751436AbWA0KWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 05:22:09 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Adrian Bunk <bunk@stusta.de>, acx100-devel@lists.sourceforge.net
Subject: Re: [-mm patch] drivers/net/wireless/tiacx/: remove code for WIRELESS_EXT < 18
Date: Fri, 27 Jan 2006 12:19:24 +0200
User-Agent: KMail/1.8.2
Cc: "John W. Linville" <linville@tuxdriver.com>, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060122171104.GC10003@stusta.de>
In-Reply-To: <20060122171104.GC10003@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601271219.24332.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,


On Sunday 22 January 2006 19:11, Adrian Bunk wrote:
> WIRELESS_EXT < 18 will never be true in the kernel.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Please don't do this. We are not in the kernel yet.

acx currently is in -mm, not in mainline.

We have quite a few users of it which aren't using -mm,
but instead compile it out-of-kernel.

We gradually removed 2.4 compat code and most of early 2.6isms.
Even that produced a few complains. Currently out-of-tree acx
is working for any kernel >= 2.6.10.

I very much want to get rid of all remaining compat cruft, and
I plan to do it as soon as acx will be present in mainline kernel.
--
vda
