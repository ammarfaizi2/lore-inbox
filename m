Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUDZUTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUDZUTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 16:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUDZUTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 16:19:06 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:39555 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263444AbUDZUTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 16:19:03 -0400
Message-ID: <408D6EB2.8060109@nortelnetworks.com>
Date: Mon, 26 Apr 2004 16:18:58 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jadevree@mtu.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: hsf modem drivers lying about their license
References: <20040426195015.GA23220@icu2.csl.mtu.edu>
In-Reply-To: <20040426195015.GA23220@icu2.csl.mtu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon DeVree wrote:
> Someone needs to take a look at the MODULE_LICENSE string reported by
> the HSF modem drivers made by LinuxAnt.
> 
> http://www.linuxant.com/drivers/hsf/full/downloads.php
> 
> They creatively inserted a \0 character in it.
> MODULE_LICENSE("GPL\0for files in the \"GPL\" directory; for others,
> only LICENSE file applies");
> 
> Runnning modinfo -F license on the compiled driver gives:
> GPL because of their creative null character. The actual license for most of
> the files is NOT GPL.

Ewww...that's evil.

Maybe we need to store the size of the license string for modinfo, so it doesn't stop at the first null?

Chris
