Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280978AbRKGU7V>; Wed, 7 Nov 2001 15:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280979AbRKGU7K>; Wed, 7 Nov 2001 15:59:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30477 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280978AbRKGU7A>; Wed, 7 Nov 2001 15:59:00 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Yet another design for /proc. Or actually /kernel.
Date: 7 Nov 2001 12:58:24 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9sc79g$413$1@cesium.transmeta.com>
In-Reply-To: <slrn9uj1nf.5lj.spamtrap@dexter.hensema.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <slrn9uj1nf.5lj.spamtrap@dexter.hensema.xs4all.nl>
By author:    spamtrap@use.reply-to (Erik Hensema)
In newsgroup: linux.dev.kernel
> 
> - Multiple values per file when needed
> 	A file is a two dimensional array: it has lines and every line
> 	can consist of multiple fields.
> 	A good example of this is the current /proc/mounts.
> 	This can be parsed very easily in all languages.
> 	No need for single-value files, that's oversimplification.
> 

Actually, /proc/mounts is currently broken, and is an excellent
example of why the above statement simply isn't true unless you apply
another level of indirection: try mounting something on a directory
the name of which contains whitespace in any form (remember, depending
on your setup this may be doable by an unprivileged user...)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
