Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288575AbSATWBZ>; Sun, 20 Jan 2002 17:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288473AbSATWBP>; Sun, 20 Jan 2002 17:01:15 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:43282 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288579AbSATWBE>;
	Sun, 20 Jan 2002 17:01:04 -0500
Date: Sun, 20 Jan 2002 20:00:51 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Shawn <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4B3B67.60505@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201201956480.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Hans Reiser wrote:

> >This means that if the VM asks to get a particular page
> >freed, at the very minimum you need to make a page from the
> >same zone freeable.
>
> I'll discuss with Josh tomorrow how we might implement support for that.
>   A clean and simple mechanism does not come to my mind immediately.

Note that in order to support more reliable allocation of
contiguous memory areas (eg. for loading modules) we may
also want to add some simple form of defragmentation to
the VM.

If you really want to make life easy for the VM, ->writepage()
should work towards making the page it is called for freeable.

You probably want to do this since an easy VM is good for
performance and it would be embarrasing if reiserfs had the
worst performance under load simply due to bad interaction
with other subsystems...

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

