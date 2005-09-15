Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030565AbVIOS0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030565AbVIOS0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 14:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030566AbVIOS0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 14:26:13 -0400
Received: from terminus.zytor.com ([209.128.68.124]:62417 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030565AbVIOS0M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 14:26:12 -0400
Message-ID: <4329BCAB.1090106@zytor.com>
Date: Thu, 15 Sep 2005 11:25:47 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4B2ZV-2dl-7@gated-at.bofh.it> <4HKbZ-Cx-37@gated-at.bofh.it> <4329BC43.7030406@v.loewis.de>
In-Reply-To: <4329BC43.7030406@v.loewis.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin v. Löwis wrote:
> 
> Says who? In UTF-8, it is not used to indicate a byte order; instead,
> it is used to indicate the fact that the file is UTF-8, like a magic.
> That's why I prefer to call it "UTF-8 signature".
> 
> The Unicode consortium thinks that the BOM can be used in UTF-8:
> 
> http://www.unicode.org/faq/utf_bom.html#29
> 
> The UTF-8 signature is very useful, and I would prefer if it would
> be used instead of format-specific encoding declarations.
> 

In Unix, it's a hideously bad idea.  The reason is that Unix inherently 
assumes that text streams can be merged, split, and modified.  In other 
words, unless you can guarantee that EVERY program can handle BOM 
EVERYWHERE, it's broken.

In other words, it's broken.

	-hpa

