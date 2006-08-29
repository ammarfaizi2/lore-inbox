Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965408AbWH2VQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965408AbWH2VQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 17:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965403AbWH2VQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 17:16:32 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:36782 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965408AbWH2VQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 17:16:30 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44F4ADD7.4020604@s5r6.in-berlin.de>
Date: Tue, 29 Aug 2006 23:12:55 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] BLOCK: Make USB storage depend on SCSI rather than
 selecting it [try #6]
References: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com> <20060829180631.32596.69574.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829180631.32596.69574.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> This makes CONFIG_USB_STORAGE depend on CONFIG_SCSI rather than selecting it,
> as selecting it makes CONFIG_USB_STORAGE override the dependencies of SCSI,
> causing it to turn on even if they aren't all met.
[...]
>  config USB_STORAGE
>  	tristate "USB Mass Storage support"
> -	depends on USB
> -	select SCSI
> +	depends on USB && SCSI
>  	---help---
>  	  Say Y here if you want to connect USB mass storage devices to your
>  	  computer's USB port. This is the driver you need for USB
[...]

What about this?

  	depends on USB
+	select BLOCK
  	select SCSI

-- 
Stefan Richter
-=====-=-==- =--- ===-=
http://arcgraph.de/sr/
