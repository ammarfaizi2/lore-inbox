Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263419AbRFNRSh>; Thu, 14 Jun 2001 13:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263416AbRFNRS1>; Thu, 14 Jun 2001 13:18:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1549 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263419AbRFNRSK>; Thu, 14 Jun 2001 13:18:10 -0400
Subject: Re: RFC: from FIBMAP to FIONDEV
To: j@falooley.org (Jason Lunz)
Date: Thu, 14 Jun 2001 18:16:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, almesber@lrc.di.epfl.ch
In-Reply-To: <20010614100354.A2129@orr.falooley.org> from "Jason Lunz" at Jun 14, 2001 10:03:54 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15AajU-0004wp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm looking for a way to do FIBMAP on linux 2.4 without being root, and
> I learned from the archive that it's restricted for security reasons,
> and that it's obsolete anyway.  I found this discussion about a
> replacement called FIONDEV:

FIBMAP can be handled per fs by auditing the code paths. First job would be
to push the security check into each fs, then audit the fs's and then change
them. But its really a 2.5 job since any third party fs might spontaneously
become insecure oitherwise
