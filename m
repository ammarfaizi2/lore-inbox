Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135574AbREHWCm>; Tue, 8 May 2001 18:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135548AbREHWCc>; Tue, 8 May 2001 18:02:32 -0400
Received: from mail.kerrvayne.com ([216.123.24.242]:20237 "HELO
	kvsgate1.kvsnetdomain.kvs.com") by vger.kernel.org with SMTP
	id <S135574AbREHWCS>; Tue, 8 May 2001 18:02:18 -0400
From: "James H. Puttick" <james.puttick@kvs.com>
Organization: Kerr Vayne Systems Ltd.
To: Urban Widmark <urban@teststation.com>
Date: Tue, 8 May 2001 18:02:02 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH][RFT] smbfs bugfixes for 2.4.4
CC: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Xuan Baldauf <xuan--lkml@baldauf.org>
Message-ID: <3AF8349A.6206.1C3850C@localhost>
In-Reply-To: <9d6mur$df1$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0105082131350.4308-100000@cola.teststation.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, I broke it when copying the ncpfs dircache code.
> 
> That code will reuse an old inode if it already exists (and thus also
> any pages attached to it), which is what I wanted and should be fine
> except that it needs to invalidate_inode_pages() if something changed.
> 
> Xuan and James, you have both seen this bug with smbfs not properly
> handling changes made on the server. Could you please test this patch
> vs 2.4.4 and let me know if it helps or not.
> 
> http://www.hojdpunkten.ac.se/054/samba/smbfs-2.4.4-truncate+retry-4.patch

Urban:

I am actually using a 2.4.3 kernel, rather than 2.4.4. However, I 
manually applied the patches to my 2.4.3 kernel, and did some tests - 
it appears to work now!

I probably won't be using Samba heavily until next week, but I will let 
you know if I see any evidence that the problem is not fixed.

Thank you very much for the fix.

-- James


----------------------------------------
James H. Puttick

Kerr Vayne Systems Ltd.
1 Valleywood Drive, Unit 5A
Markham, Ontario L3R 5L9
Canada

+1 905 475 6161  office
+1 905 479 9833  fax

mailto:james.puttick@kvs.com
----------------------------------------
