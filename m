Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276682AbRJKSfc>; Thu, 11 Oct 2001 14:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276684AbRJKSfW>; Thu, 11 Oct 2001 14:35:22 -0400
Received: from web10305.mail.yahoo.com ([216.136.130.83]:10766 "HELO
	web10305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276682AbRJKSfF>; Thu, 11 Oct 2001 14:35:05 -0400
Message-ID: <20011011183533.99436.qmail@web10305.mail.yahoo.com>
Date: Thu, 11 Oct 2001 19:35:33 +0100 (BST)
From: "=?iso-8859-1?q?J.D.=20Hood?=" <jdthood@yahoo.co.uk>
Subject: Re: [PATCH] 2.4.10-ac11 parport_pc.c bugfix
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fact that (unsigned long)-1 and ~0U have different 
values on different arches isn't a problem.

What would be a problem is if (unsigned long)-1 were liable
to be given different values by different compilers, and
especially if (unsigned long)-1 were liable to be cast to
some number between 0 and 15.  But I assume that the type
casting rules of C prohibit this---that (unsigned long)-1
is assured to be some very large positive integer.  (Indeed,
the largest.)  However I'm uncertain enough about this
assumption that I raise the present question about it.

Assuming that the assumption is correct [:)], the patch is fine
as it is and should go in.

BTW what problem is it you are having with PnP BIOS on your arch?
Can you refer me to a past thread title?

--
Thomas

____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
