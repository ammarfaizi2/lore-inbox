Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbTGaTOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 15:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274860AbTGaTOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 15:14:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267705AbTGaTOu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 15:14:50 -0400
Date: Thu, 31 Jul 2003 15:14:37 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Ata, John" <John.Ata@DigitalNet.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: incompatible open modes
In-Reply-To: <6DED202D454D3B4EB7D98A7439218D610C9AB8@vahqex2.gfgsi.com>
Message-ID: <Pine.LNX.4.53.0307311503350.180@chaos>
References: <6DED202D454D3B4EB7D98A7439218D610C9AB8@vahqex2.gfgsi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003, Ata, John wrote:

> Hi Andries,
>
> If that's what's been decided... I presume for backwards compatability,
> but it does seem rather odd though.  After all, it seems like O_RDONLY
> is supposed to safeguard someone from accidently overwriting a file.
> Otherwise why not automatically open everything read/write?  Going down
> the same path, what's next: automatically write enabling a file which
> has been openend for O_RDONLY the next time someone performs a write
> operation on it? ;-)
>
> Take care,
> John

Historically, the word "undefined" has become synonymous with
"worst possible thing" under Unix. If some operation is "undefined"
the implementor is free to low-level format your hard disk.

This is not a good thing. For instance, the MS-DOS 'open' has
defaults that are not harmful. Not so with Unix. There are no
defaults! You must be explicit. You can even create a file you
can't delete if you don't set the permissions correctly when
opening O_CREAT. Note you can even create a file called "*" and
"*.*". So, under Unix you gotta be careful. Like somebody's
.sig said; "Unix gives you enough rope to shoot yourself!"

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

