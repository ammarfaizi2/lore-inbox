Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbTDKBAn (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 21:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbTDKBAm (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 21:00:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:10154 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264282AbTDKBAi convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 21:00:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Date: Thu, 10 Apr 2003 18:09:55 -0700
User-Agent: KMail/1.4.1
References: <UTC200304102353.h3ANrXv10792.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200304102353.h3ANrXv10792.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304101809.55311.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 April 2003 04:53 pm, Andries.Brouwer@cwi.nl wrote:
>     From: Badari Pulavarty <pbadari@us.ibm.com>
>
>     >     I am more worried about names slipping. I atleast hope
>     >     to see device names not changing by just doing
>     >     rmmod/insmod.
>     >
>     > But you see, the present sd_index_bits[] gives no such
>     > guarantee. In sd_detach a bit is cleared, in sd_attach
>     > the first free bit is given out. There is no memory.
>
>     But the disks are probed in the same manner as last time
>     (if the disks/controllers are not moved, crashed etc..).
>     So we will end up getting same names.
>
> Oh, but if next_index is 0 in the module (or reset by the
> init_module code), then also with index = next_index++
> things will be the same after rmmod/insmod.

Here is my problem..

#insmod ips.o
  < found 10 disks>
#insmod qla2300.o
  < found 10 disks>
#rmmod ips.o
   <removed 10 disks>
#insmod ips.o
  <found 10 disks - but new names>

- Badari
