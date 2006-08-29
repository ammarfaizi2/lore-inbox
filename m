Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWH2BQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWH2BQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWH2BQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:16:00 -0400
Received: from main.gmane.org ([80.91.229.2]:16555 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750830AbWH2BP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:15:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Date: Tue, 29 Aug 2006 04:15:49 +0200
Organization: Palacky University in Olomouc, experimental physics dep.
Message-ID: <44F3A355.6090408@flower.upol.cz>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com>	 <1156803102.3465.34.camel@mulgrave.il.steeleye.com>	 <20060828230452.GA4393@powerlinux.fr>  <44F38BCE.2080108@flower.upol.cz> <1156809344.3465.41.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <1156809344.3465.41.camel@mulgrave.il.steeleye.com>
Cc: debian-kernel@lists.debian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Tue, 2006-08-29 at 02:35 +0200, Oleg Verych wrote:
> 
>>request_firmware() is dead also.
>>YMMV, but three years, and there are still big chunks of binary in kernel.
>>And please don't add new useless info _in_ it.
> 
> 
> I er don't think so.
> 
Hell, what can be as easy as this:
,-
|modprobe $drv
|(dd </lib/firmware/$drv.bin>/dev/blobs && echo OK) || echo Error
`-
where /dev/blobs is similar to /dev/port or even /dev/null char device.
if synchronization is needed, add `echo $drv >/dev/blobs`, remove modprobe,

> 
> James
> 
?

-- 
--
-o--=O`C  /. .\   (+)
  #oo'L O      o    |
<___=E M    ^--    |  (you're barking up the wrong tree)

