Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263625AbRFYVns>; Mon, 25 Jun 2001 17:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264066AbRFYVni>; Mon, 25 Jun 2001 17:43:38 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:51719 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263625AbRFYVnS>; Mon, 25 Jun 2001 17:43:18 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: EXT2 Filesystem permissions (bug)?
Date: 25 Jun 2001 14:42:50 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9h8b8q$s95$1@cesium.transmeta.com>
In-Reply-To: <m28zigi7m4.fsf@boreas.yi.org.> <Pine.LNX.4.30.0106251729450.18996-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.30.0106251729450.18996-100000@coredump.sh0n.net>
By author:    Shawn Starr <spstarr@sh0n.net>
In newsgroup: linux.dev.kernel
> 
> Is this a bug or something thats undocumented somewhere?
> 
> d--------T
> and
> drwSrwSrwT
> 
> are these special bits? I'm not aware of +S and +T
> 

It's neither a bug nor undocumented.

"info ls" would have told you the following:

     The permissions listed are similar to symbolic mode
     specifications
     (*note Symbolic Modes::.).  But `ls' combines multiple bits into
     the third character of each set of permissions as follows:
    `s'
          If the setuid or setgid bit and the corresponding executable
          bit are both set.

    `S'
          If the setuid or setgid bit is set but the corresponding
          executable bit is not set.

    `t'
          If the sticky bit and the other-executable bit are both set.

    `T'
          If the sticky bit is set but the other-executable bit is not
          set.

    `x'
          If the executable bit is set and none of the above apply.

    `-'
          Otherwise.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
