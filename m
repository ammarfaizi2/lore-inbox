Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUCIBRw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 20:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUCIBRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 20:17:52 -0500
Received: from smtp01.web.de ([217.72.192.180]:48905 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261440AbUCIBRv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 20:17:51 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix warning about duplicate 'const'
Date: Tue, 9 Mar 2004 02:17:37 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200403090043.21043.thomas.schlichter@web.de> <20040308161410.49127bdf.akpm@osdl.org> <Pine.LNX.4.58.0403081627450.9575@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403081627450.9575@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200403090217.40867.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 9. März 2004 01:32 schrieb Linus Torvalds:

~~ snip ~~

> The warnings the extra "const" fixes is something like:
>
> 	int a;
> 	const int b;
>
> 	min(a,b)
>
> where otherwise it would complain about pointers to different types when
> comparing the type of the pointer. Or something.

OK, I tested it and gcc 3.3.1 does not complain about this. So with my patch, 
the duplicate 'const' warning goes away here and no other warning occours...

But I don't know how other versions of gcc behave...

   Thomas

