Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUG0KJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUG0KJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 06:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUG0KJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 06:09:56 -0400
Received: from mail.gmx.de ([213.165.64.20]:19106 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261951AbUG0KJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 06:09:52 -0400
X-Authenticated: #1725425
Date: Tue, 27 Jul 2004 12:10:40 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Junio C Hamano <junkio@cox.net>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Message-Id: <20040727121040.27ca7170.Ballarin.Marc@gmx.de>
In-Reply-To: <7v4qntc06o.fsf@assigned-by-dhcp.cox.net>
References: <20040726200126.GQ5414@waste.org>
	<7v4qntc06o.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 01:40:47 -0700
Junio C Hamano <junkio@cox.net> wrote:

> 
> Jari's exploit uses the property that his watermarks are
> encrypted to identical ciphertext blocks, but does it mean that
> the technique can be used to prove that identical ciphertext are
> from the watermarks and not coming from mere coincidence?
> 

You can't prove anything by a single found watermark, but you can encode
additional information by placing the watermarks at chosen offsets in your
file.

For example, take prime numbers starting at 2 as offsets, and place the
encodings in a chosen order at those offsets.

The chances for a random occurence of this pattern are marginal, and -
unless the watermarked file becomes strongly fragmented - this pattern is
easy to retrieve.

While this might not be evidence in the legal sense (it could well be, but
IANAL), it is at the very least a strong indication.

Regards
