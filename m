Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129819AbRAHRNr>; Mon, 8 Jan 2001 12:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130367AbRAHRNi>; Mon, 8 Jan 2001 12:13:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:19722 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129819AbRAHRN1>; Mon, 8 Jan 2001 12:13:27 -0500
Date: Mon, 8 Jan 2001 09:12:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs is ro only, so honour this in inode->mode
In-Reply-To: <20010108141702.I10035@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.10.10101080912010.3750-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Ingo Oeser wrote:
> 
> cramfs is a read-only fs. So we should honour that in inode->mode to
> avoid confusion of programs.

No no no. This breaks device nodes etc quite badly.

A change to mkcramfs might be fine - but it has to conditionalize on the
file being a regular file. Not a blanket "everything is read-only".

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
