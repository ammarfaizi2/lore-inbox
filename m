Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310157AbSCFUYc>; Wed, 6 Mar 2002 15:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310141AbSCFUYX>; Wed, 6 Mar 2002 15:24:23 -0500
Received: from mnh-1-14.mv.com ([207.22.10.46]:29704 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S310168AbSCFUYL>;
	Wed, 6 Mar 2002 15:24:11 -0500
Message-Id: <200203062025.PAA03727@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dwmw2@infradead.org (David Woodhouse), hpa@zytor.com (H. Peter Anvin),
        bcrl@redhat.com (Benjamin LaHaise), linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Wed, 06 Mar 2002 16:50:15 GMT."
             <E16iecJ-0007Nn-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Mar 2002 15:25:00 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> Doesn't seem to but it looks like madvise might be enough to make that
> happen.

Yeah, MADV_DONTNEED looks right.  UML and Linux/s390 (assuming VM has the
equivalent of MADV_DONTNEED) would need a hook in free_pages to make that
happen.

> That BTW is an issue for more than UML - it has a bearing on running
> lots of Linux instances on any supervisor/virtualising system like S/390

On a side note, the "unused memory is wasted memory" behavior that UML and 
Linux/s390 inherit is also less than optimal for the host.

				Jeff

