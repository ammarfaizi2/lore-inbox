Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262997AbTC0PTy>; Thu, 27 Mar 2003 10:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262998AbTC0PTy>; Thu, 27 Mar 2003 10:19:54 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:21905 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262997AbTC0PTx>; Thu, 27 Mar 2003 10:19:53 -0500
Date: Thu, 27 Mar 2003 16:30:54 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: zlib in the kernel?
Message-ID: <20030327153054.GC25094@wohnheim.fh-wedel.de>
References: <20030327150659.GC802@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030327150659.GC802@rdlg.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 March 2003 10:06:59 -0500, Robert L. Harris wrote:
> 
> Anyone have a good breakdown on what this is?  I have some wild theories
> I'm hoping are right but don't need to start another day looking like an
> idiot guessing blindly.
> 
> The Help section is empty and I'm not finding anything on kernel.org
> (may have overlooked something, the site is slow for me today)..

Zlib compression is used in many places in the kernel, cramfs, jffs2,
squashfs, zisofs, cloop, ppp, maybe more.

There used to be several copies of the code in the kernel tree, I
still have a not-so-old compiled kernel with *three* copies of the
zlib code in it. It's centralized now under lib/, which is a good
thing (TM).

When configuring the kernel, chances are you don't have to touch it.
Anything else should be reported and get fixed. :)

Jörn

-- 
Fancy algorithms are slow when n is small, and n is usually small.
Fancy algorithms have big constants. Until you know that n is
frequently going to be big, don't get fancy.
-- Rob Pike
