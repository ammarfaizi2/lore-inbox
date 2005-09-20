Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbVITMzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVITMzy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 08:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVITMzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 08:55:54 -0400
Received: from [195.209.228.254] ([195.209.228.254]:42963 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S965004AbVITMzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 08:55:53 -0400
Message-ID: <433006D8.4010502@yandex.ru>
Date: Tue, 20 Sep 2005 16:55:52 +0400
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Peter Menzebach <pm-mtd@mw-itcon.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: data  loss on jffs2 filesystem on dataflash
References: <432812E8.2030807@mw-itcon.de>	<432817FF.10307@yandex.ru>	<4329251C.7050102@mw-itcon.de>	<4329288B.8050909@yandex.ru> <43292AC6.40809@mw-itcon.de>	<43292E16.70401@yandex.ru> <43292F91.9010302@mw-itcon.de> <432FE1EF.9000807@yandex.ru> <432FEF55.5090700@mw-itcon.de>
In-Reply-To: <432FEF55.5090700@mw-itcon.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Menzebach wrote:
> No, not at then moment. If I have some time, I can try to rewrite the 
> chipset driver, that it reports a sector size of 1024.

I glanced at the manual. Uhh, DataFlash is very specific beast. It 
suppoers page program with built-in erase command... So DataFlash 
effectively may be considered as a block device. Then you may use any FS 
on it providing you have wrote proper driver? Why do you need JFFS2 then 
:-) ?

JFFS2 orients to "classical" flashes. They have no "write page with 
built-in erase" operation.

Didn't read the manual carefully, what do they refer by "Main memory array"?

BTW, having 8*1056 write buffer is not perfect ides, better make it as 
small as possible, i.e., 1056 bytes.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
