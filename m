Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269104AbRHBTkR>; Thu, 2 Aug 2001 15:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269111AbRHBTkH>; Thu, 2 Aug 2001 15:40:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56837 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269104AbRHBTjy>; Thu, 2 Aug 2001 15:39:54 -0400
Subject: Re: [PATCH] vxfs fix
To: Andries.Brouwer@cwi.nl
Date: Thu, 2 Aug 2001 20:41:00 +0100 (BST)
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, hch@caldera.de,
        linux-kernel@vger.kernel.org, viro@math.psu.edu
In-Reply-To: <no.id> from "Andries.Brouwer@cwi.nl" at Aug 02, 2001 07:15:31 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SOL6-0001JZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	From: Alan
> 
> 	Alternatively pass a flag to the mount command saying
> 	"this is a guesswork special" then V7 fs can just return 'not me'
> 
> Parse failure.

Let me try again:

When the read_super method is invoked
AND we are doing a mount without a defined type
	THEN
		Pass the fs a flag from the VFS saying so
	ENDIF

That way the file system can actually say "I cannot reliably check"
