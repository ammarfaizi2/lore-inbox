Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129412AbRBDJsU>; Sun, 4 Feb 2001 04:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129976AbRBDJsL>; Sun, 4 Feb 2001 04:48:11 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:44748 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129412AbRBDJsA>; Sun, 4 Feb 2001 04:48:00 -0500
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch?] RAMFS
In-Reply-To: <Pine.Linu.4.10.10102040713280.663-100000@mikeg.weiden.de>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <Pine.Linu.4.10.10102040713280.663-100000@mikeg.weiden.de>
Message-ID: <m3r91en5jj.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 04 Feb 2001 10:53:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <mikeg@wen-online.de> writes:

> However, tmpfs appears to cover the functionality provided by ramfs.
> Are there any uses for ramfs which can't be handled by tmpfs?

Nothing I know of.

> The only thing I could think of was "what if you don't have a
> swap device up and running".  Seems it doesn't need one :))

Yes and no. tmpfs has a little bit overhead for the noswap case but
this overhead is in the kernel anyways for shared anon mappings. The
whole vm is using swap unconditionally.

Greetings
                Christoph



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
