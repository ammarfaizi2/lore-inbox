Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292665AbSCDSfZ>; Mon, 4 Mar 2002 13:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292660AbSCDSfK>; Mon, 4 Mar 2002 13:35:10 -0500
Received: from mnh-1-26.mv.com ([207.22.10.58]:3846 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S292668AbSCDSdw>;
	Mon, 4 Mar 2002 13:33:52 -0500
Message-Id: <200203041836.NAA03308@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Mon, 04 Mar 2002 18:29:27 GMT."
             <E16hxDD-00007f-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Mar 2002 13:36:06 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> alloc_pages is only called at the time the backing page is created -
> by then it doesnt matter - its too late.

*My* (i.e. the one inside UML) alloc_pages, not the host's would do the
dirtying.  That's the whole point.  The UML alloc_pages would make sure
that the pages it hands out are backed on the host before they are handed
out to the rest of UML.

				Jeff

