Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311948AbSDSJ1a>; Fri, 19 Apr 2002 05:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312119AbSDSJ13>; Fri, 19 Apr 2002 05:27:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1549 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311948AbSDSJ13>; Fri, 19 Apr 2002 05:27:29 -0400
Subject: Re: Bio pool & scsi scatter gather pool usage
To: lord@sgi.com (Stephen Lord)
Date: Fri, 19 Apr 2002 09:58:36 +0100 (BST)
Cc: akpm@zip.com.au (Andrew Morton), alan@lxorguk.ukuu.org.uk (Alan Cox),
        peloquin@us.ibm.com (Mark Peloquin), linux-kernel@vger.kernel.org
In-Reply-To: <3CBFC755.50106@sgi.com> from "Stephen Lord" at Apr 19, 2002 02:29:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16yUE0-0006i7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But this gets you lowest common denominator sizes for the whole
> volume, which is basically the buffer head approach, chop all I/O up
> into a chunk size we know will always work. Any sort of nasty  boundary
> condition at one spot in a volume means the whole thing is crippled
> down to that level. It then becomes a black magic art to configure a
> volume which is not restricted to a small request size.

Its still cheaper to merge bio chains than split them. The VM issues with
splitting them are not nice at all since you may need to split a bio to
write out a page and it may be the last page
