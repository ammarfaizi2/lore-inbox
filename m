Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTKQPkM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 10:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbTKQPkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 10:40:12 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:9124 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263571AbTKQPkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 10:40:08 -0500
Message-ID: <3FB8EBC2.1080800@nortelnetworks.com>
Date: Mon, 17 Nov 2003 10:39:46 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is initramfs freed after kernel is booted?
References: <E1ALlQs-000769-00.arvidjaar-mail-ru@f7.mail.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:

> my example is after pivot_root. I still have two roots.
> 
> To clarify. I want to replace initrd with initramfs. Given all
> the stuff may be put in it can easily be expanded to a couple of MBs.
> initrd frees this. I do not want to waste RAM to leave them in initramfs.

Absolutely, the memory should be reclaimed.  I would have thought that 
you could just unmount it--if the pivot_root is done properly there 
shouldn't be any references left to the initramfs.

Jeff?

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

