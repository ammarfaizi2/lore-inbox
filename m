Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277341AbRKVLbf>; Thu, 22 Nov 2001 06:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRKVLbZ>; Thu, 22 Nov 2001 06:31:25 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:9576 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S277341AbRKVLbN>; Thu, 22 Nov 2001 06:31:13 -0500
Date: Thu, 22 Nov 2001 06:31:09 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Giacomo Catenazzi <cate@debian.org>
Cc: ncw@axis.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Asm style
Message-ID: <20011122063109.O4087@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <fa.derh1nv.1h0ai0b@ifi.uio.no> <fa.njuqm5v.100c5ak@ifi.uio.no> <3BFD0BB3.2000000@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BFD0BB3.2000000@debian.org>; from cate@debian.org on Thu, Nov 22, 2001 at 03:29:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 03:29:07PM +0100, Giacomo Catenazzi wrote:
> gcc should warn in both case (when calling it with -pedantic -ansi).
> But forget my comment:
> Talking about ANSI C for asm construct doen't make much sense.

It should not warn.
Please read ISO C99 5.1.1.2:
2.  Each instance of a backslash character (\) immediately followed by a new-line
    character is deleted, splicing physical source lines to form logical source lines.
    Only the last backslash on any physical source line shall be eligible for being part
    of such a splice. A source file that is not empty shall end in a new-line character,
    which shall not be immediately preceded by a backslash character before any such
    splicing takes place.
This happens even before tokenizing (and before macro expansion too).

	Jakub
