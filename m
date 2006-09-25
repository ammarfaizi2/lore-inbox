Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWIYLvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWIYLvp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWIYLvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:51:45 -0400
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:29880 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1751478AbWIYLvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:51:44 -0400
Message-ID: <4517C2CC.4070900@grupopie.com>
Date: Mon, 25 Sep 2006 12:51:40 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Michael Tokarev <mjt@tls.msk.ru>, Johannes Stezenbach <js@linuxtv.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Dax Kelson <dax@gurulabs.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
References: <1158870777.24172.23.camel@mentorng.gurulabs.com> <20060921204250.GN13641@csclub.uwaterloo.ca> <45130792.9040104@zytor.com> <20060922140007.GK13639@csclub.uwaterloo.ca> <Pine.LNX.4.61.0609221811560.12304@yvahk01.tjqt.qr> <4514103D.8010303@zytor.com> <20060922174137.GA29929@linuxtv.org> <451426C9.9040002@zytor.com> <4514292C.5000309@tls.msk.ru> <45142AF1.1090806@zytor.com>
In-Reply-To: <45142AF1.1090806@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Michael Tokarev wrote:
>>[...]
>> On the site it's said lzma(sdk) is under rewrite to support
>> new format with magic number and crc checks...
> 
> That is an absolute must, IMO.  I would use the gzip format as a base.

If you're suggesting a gzip like format (but with different magic, 
etc.), that's ok.

However, it has been suggested on similar threads to use the CM field of 
the gzip format to introduce different compression methods.

While this is the purpose of this field, I find this to be a very bad 
idea. The worse part of it is that, after "lzma gzip" files start to 
proliferate, you never know if you can decompress a .gz with your 
version of gunzip, which is something that you currently have for granted.

If more formats start being supported inside gzip, this only gets worse...

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
