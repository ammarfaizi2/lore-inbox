Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281000AbRKGVVg>; Wed, 7 Nov 2001 16:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280990AbRKGVUi>; Wed, 7 Nov 2001 16:20:38 -0500
Received: from h226-58.adirondack.albany.edu ([169.226.226.58]:33161 "EHLO
	bouncybouncy.net") by vger.kernel.org with ESMTP id <S280994AbRKGVTe>;
	Wed, 7 Nov 2001 16:19:34 -0500
Date: Wed, 7 Nov 2001 16:19:29 -0500
From: Justin A <justin@bouncybouncy.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Yet another design for /proc. Or actually /kernel.
Message-ID: <20011107161929.A22295@bouncybouncy.net>
In-Reply-To: <slrn9uj1nf.5lj.spamtrap@dexter.hensema.xs4all.nl> <9sc79g$413$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9sc79g$413$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh yes I've seen that happen.  It's not too common in standard unix
practices, but comes up a lot when mounting windows shares.  Mounting
"//bobs computer/my folder with stuff in it" does not have good results.
Only way I found to fix that was to umount -a -t smbfs.

-Justin

On Wed, Nov 07, 2001 at 12:58:24PM -0800, H. Peter Anvin wrote:
> Followup to:  <slrn9uj1nf.5lj.spamtrap@dexter.hensema.xs4all.nl>
> By author:    spamtrap@use.reply-to (Erik Hensema)
> In newsgroup: linux.dev.kernel
> > 
> > - Multiple values per file when needed
> > 	A file is a two dimensional array: it has lines and every line
> > 	can consist of multiple fields.
> > 	A good example of this is the current /proc/mounts.
> > 	This can be parsed very easily in all languages.
> > 	No need for single-value files, that's oversimplification.
> > 
> 
> Actually, /proc/mounts is currently broken, and is an excellent
> example of why the above statement simply isn't true unless you apply
> another level of indirection: try mounting something on a directory
> the name of which contains whitespace in any form (remember, depending
> on your setup this may be doable by an unprivileged user...)
> 
> 	-hpa
> -- 
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
