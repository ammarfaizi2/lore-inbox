Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276457AbRJHGXO>; Mon, 8 Oct 2001 02:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276646AbRJHGXE>; Mon, 8 Oct 2001 02:23:04 -0400
Received: from rj.sgi.com ([204.94.215.100]:8326 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S276457AbRJHGWw>;
	Mon, 8 Oct 2001 02:22:52 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zisofs doesn't compile in 2.4.10-ac7 
In-Reply-To: Your message of "Mon, 08 Oct 2001 15:53:20 +1000."
             <2772.1002520400@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Oct 2001 16:22:59 +1000
Message-ID: <2881.1002522179@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Oct 2001 15:53:20 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>Good idea.  kbuild 2.5 starting with 2.4.11-pre5 forces the kernel to
>only use its own includes plus gcc install includes.  No more scanning
>/usr/include for kernel compiles.

Guess what the first bit of code was that broke?  Yep, aic7xxx strikes
again, it includes endian.h :(.  I am not going to fix it, the aic7xxx
maintainer is not interested in conforming to kernel build procedures,
aic7xxx is a shambles.

The code might be the best thing since SCSI-1 but the build of aic7xxx
causes more problems for kbuild than the rest of the system put
together.

