Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbRFZWXn>; Tue, 26 Jun 2001 18:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265131AbRFZWXY>; Tue, 26 Jun 2001 18:23:24 -0400
Received: from mailc.telia.com ([194.22.190.4]:50398 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S265130AbRFZWXV>;
	Tue, 26 Jun 2001 18:23:21 -0400
Message-ID: <3B390B48.D444B7C5@canit.se>
Date: Wed, 27 Jun 2001 00:23:04 +0200
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: EXT2 Filesystem permissions (bug)?
In-Reply-To: <m28zigi7m4.fsf@boreas.yi.org.> <Pine.LNX.4.30.0106251729450.18996-100000@coredump.sh0n.net> <9h8b8q$s95$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting but I wonder how much this helps someone that not already know what it is. Should not the ls manual also contain something that explains the meaning instead of just the mapping from bits to symbol.

Do linux even support the sticky bit (t) I can't see a reason to use it, why would I want the file to be stored in the swap ?? 

Also I think S (setuid but no execute bit) have something to do with file locking but I'am not shure exactly how it works. 

"H. Peter Anvin" wrote:
> 
> Followup to:  <Pine.LNX.4.30.0106251729450.18996-100000@coredump.sh0n.net>
> By author:    Shawn Starr <spstarr@sh0n.net>
> In newsgroup: linux.dev.kernel
> >
> > Is this a bug or something thats undocumented somewhere?
> >
> > d--------T
> > and
> > drwSrwSrwT
> >
> > are these special bits? I'm not aware of +S and +T
> >
> 
> It's neither a bug nor undocumented.
> 
> "info ls" would have told you the following:
> 
>      The permissions listed are similar to symbolic mode
>      specifications
>      (*note Symbolic Modes::.).  But `ls' combines multiple bits into
>      the third character of each set of permissions as follows:
>     `s'
>           If the setuid or setgid bit and the corresponding executable
>           bit are both set.
> 
>     `S'
>           If the setuid or setgid bit is set but the corresponding
>           executable bit is not set.
> 
>     `t'
>           If the sticky bit and the other-executable bit are both set.
> 
>     `T'
>           If the sticky bit is set but the other-executable bit is not
>           set.
> 
>     `x'
>           If the executable bit is set and none of the above apply.
> 
>     `-'
>           Otherwise.
> 
>         -hpa
