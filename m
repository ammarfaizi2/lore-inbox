Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275751AbRI0DSb>; Wed, 26 Sep 2001 23:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275752AbRI0DSN>; Wed, 26 Sep 2001 23:18:13 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:64528 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S275751AbRI0DR5>; Wed, 26 Sep 2001 23:17:57 -0400
Message-ID: <3BB29A7C.204CAC78@zip.com.au>
Date: Wed, 26 Sep 2001 20:18:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9: strange stale buffers when reading partition table (USB/SCSI)
In-Reply-To: <1001558230.3bb290d6a8b8e@www.goop.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> 
> 
> This is 2.4.9-linus with ext3

Handy.  You can enable ext3's buffer tracing, then add a

	print_buffer_trace(bh);

to the buffer to find out where it has been.

If that doesn't provide enough info then add more BUFFER_TRACE()
calls in strategic places.

-
