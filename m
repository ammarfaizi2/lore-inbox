Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266867AbRGLWH0>; Thu, 12 Jul 2001 18:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266883AbRGLWHR>; Thu, 12 Jul 2001 18:07:17 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:44047 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S266867AbRGLWHN>;
	Thu, 12 Jul 2001 18:07:13 -0400
Message-ID: <938F7F15145BD311AECE00508B7152DB034C48BF@vts007.vertis.nl>
From: Rolf Fokkens <FokkensR@vertis.nl>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.6: Why doesn't mprotect () check ulimit/rlim?
Date: Fri, 13 Jul 2001 00:07:03 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to restrict Oracle's memory claims I tried a strace while
making Oracle claim huge amounts of memory. It appears that Oracle claims
all it's memory by calling mprotect, which (unlike brk ()) doesn't check
rlim.
 
I don't know the details of this, but it seems a little buggy to me. If not
buggy, then what's the use of rlim?
 
Cheers,
 
Rolf
