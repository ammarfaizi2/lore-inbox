Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbTDTXoe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 19:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263739AbTDTXoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 19:44:34 -0400
Received: from hera.cwi.nl ([192.16.191.8]:39151 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263735AbTDTXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 19:44:34 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 21 Apr 2003 01:56:34 +0200 (MEST)
Message-Id: <UTC200304202356.h3KNuYK14756.aeb@smtp.cwi.nl>
To: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [CFT] more kdev_t-ectomy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > Of course it may be possible to avoid kernel-internal numbers altogether.
    > Sometimes that is an improvement, sometimes not. Pointers are more
    > complicated than numbers - they point at something that must be allocated
    > and freed and reference counted. A number is like a pointer without the
    > reference counting.

    I guess the question is: is there any point to have three forms --
    with necessary conversions between them -- or is it simpler to have
    two forms and just use the more awkward dev_t form everywhere?

It doesnt matter much. I would not have introduced kdev_t just
for slightly more efficient dev_t handling. But we have it already.
It seems meaningless to go and replace it by something more awkward
and less efficient.

[But should anyone want: globally s/kdev_t/dev_t/ and a small edit
of kdev_t.h suffices.]

    We do need a dev32_t for NFSv2 et al, though.

I don't know why.

Andries
