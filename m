Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278579AbRKFHgS>; Tue, 6 Nov 2001 02:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278587AbRKFHgH>; Tue, 6 Nov 2001 02:36:07 -0500
Received: from marine.sonic.net ([208.201.224.37]:21825 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S278579AbRKFHfz>;
	Tue, 6 Nov 2001 02:35:55 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Mon, 5 Nov 2001 23:34:52 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <20011105233452.C8276@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BE77599.9CFB5CA9@zip.com.au> <Pine.LNX.4.33.0111052141100.1480-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111052141100.1480-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 09:48:40PM -0800, Linus Torvalds wrote:
> I'm not saying it's a bad heuristic - it's probably a fine (and certainly
> simple) one. But the thought that when the NFS server has problems, a
> straight "cp -a" of the same tree results in different layout just because
> the server was moved over from one network to another makes me go "Ewww.."

The layout is most likely going to be different anyway, isn't it?  We don't
know what has gone on in the past to get the FS into the current state.

But now we have more information than we did when the file system was
originally built.

We don't have an extent based interface do we?  So we can't say "I know
this file is going to be X bytes in size."  But if we accomplish nearly the
same thing by a quick copy like this, what's the harm?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
