Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWEON41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWEON41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 09:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWEON41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 09:56:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41698 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932423AbWEON40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 09:56:26 -0400
Subject: Re: [PATCH] ide_dma_speed() fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <446885BE.4090404@ru.mvista.com>
References: <4463F4C8.9080608@ru.mvista.com>
	 <20060514050548.5399e3f4.akpm@osdl.org>  <446885BE.4090404@ru.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 15:08:55 +0100
Message-Id: <1147702135.26686.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 17:44 +0400, Sergei Shtylyov wrote:
>     That's what gcc thinks. The code is 100% correct -- it will never reach 
> the switch statement with mode > 0 (in which case ultra_mask isn't used) and 
> ultra_mask unitialized. I may add an explicit initializer in the declaration 
> if you like...

Please leave the warning, this was discussed recently in other threads
and hiding warnings is very dangerous.

