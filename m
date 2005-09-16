Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVIPTZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVIPTZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVIPTZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:25:28 -0400
Received: from terminus.zytor.com ([209.128.68.124]:61913 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751242AbVIPTZ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:25:28 -0400
Message-ID: <432B1C15.4060702@zytor.com>
Date: Fri, 16 Sep 2005 12:25:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bodo Eggert <7eggert@gmx.de>
CC: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4N6EL-4Hq-3@gated-at.bofh.it> <4N6EL-4Hq-5@gated-at.bofh.it> <4N6EK-4Hq-1@gated-at.bofh.it> <4N6EX-4Hq-27@gated-at.bofh.it> <4N6Ox-4Ts-33@gated-at.bofh.it> <4N7AS-67L-3@gated-at.bofh.it> <E1EGKXl-0001Sn-GA@be1.lrz> <432B0A47.7060909@zytor.com> <Pine.LNX.4.58.0509162029470.5708@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0509162029470.5708@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> 
> It should, but as long as old programs are still around, we'll have both 
> and need a marker to distinguish them. Otherwise we'll be stuck with
> legacy scripts for a long time.
> 

You don't have markers (although they're defined, see ISO 2022) for your 
8-bit encodings, and *THEY'RE THE ONES THAT NEED TO BE DISTINGUISHED.* 
Flagging UTF-8, especially with the BOM (as opposed to the ISO 2022 
signature, <ESC>%G) is pointless in the context, since you still can't 
distinguish your arbitrary number of legacy encodings.

Oh, yes, and try to stick ISO 2022 signatures in scripts or whatnot, and 
you can see what current software does with a signature standard that 
dates back to the 1970's.

	-hpa
