Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275416AbTHIVqK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 17:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275417AbTHIVqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 17:46:10 -0400
Received: from smtp03.web.de ([217.72.192.158]:35366 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S275416AbTHIVqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 17:46:08 -0400
Message-ID: <3F356BC6.9020904@web.de>
Date: Sat, 09 Aug 2003 23:46:46 +0200
From: Chromosom <ChromosML@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ov511 2.6.0-test3
References: <200308092115.18501.linux@1g6.biz>
In-Reply-To: <200308092115.18501.linux@1g6.biz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas P. wrote:
> It is new to kernel 2.6.0-test3 :
> 
> *** Warning: "video_proc_entry" [drivers/usb/media/ov511.ko] undefined!
> 

Try adding this to driver/media/video/videodev.c:
(e.g. after the other EXPORT_SYMBOL lines)

void *video_proc_entry;
EXPORT_SYMBOL(video_proc_entry);

Stefan B.


