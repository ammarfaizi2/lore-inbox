Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269371AbUICIMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269371AbUICIMo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269362AbUICIMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:12:42 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:53911 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S269373AbUICIJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:09:40 -0400
Message-ID: <413826C1.1010203@dgreaves.com>
Date: Fri, 03 Sep 2004 09:09:37 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: md RAID over SATA performance
References: <1094169937l.17931l.0l@werewolf.able.es> <1094172444l.17931l.1l@werewolf.able.es>
In-Reply-To: <1094172444l.17931l.1l@werewolf.able.es>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

>
> On 2004.09.03, J.A. Magallon wrote:
>
>> Hi all...
>>
>> I am buildin an array with a linux box, and I run 2.6.8.1 (not stock, 
>> but
>> the mandrake cooker version).
>>
>> Problem is that i get really poor performance. 
>

Try:
 blockdev --getra /dev/sda1
 blockdev --getra /dev/md0

and if needed:
 blockdev --setra 4096 /dev/sda1
 blockdev --setra 4096 /dev/md0

Also if you use lvm:
 blockdev --setra 4096 /dev/video_vg/video_lv
as appropriate.

Tune as needed :)

David
