Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314501AbSD1VMJ>; Sun, 28 Apr 2002 17:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314502AbSD1VMI>; Sun, 28 Apr 2002 17:12:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7174 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314501AbSD1VMI>; Sun, 28 Apr 2002 17:12:08 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How far has initramfs got ?
Date: 28 Apr 2002 13:14:58 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aahl82$97v$1@cesium.transmeta.com>
In-Reply-To: <171nLP-1WyTImC@fwd09.sul.t-online.com> <20020428174230.GE18102@ravel.coda.cs.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020428174230.GE18102@ravel.coda.cs.cmu.edu>
By author:    Jan Harkes <jaharkes@cs.cmu.edu>
In newsgroup: linux.dev.kernel
> 
> I would like to add that perhaps using tmpfs instead of ramfs would be
> a nice touch. As the initial ramfs would get overmounted instead of
> unmounted, this allows the contents of the initial fs to get swapped
> out instead of either taking up memory indefinitely.
> 

Baloney.  You can't swap out what is actively in use, and something
that's overmounted is actively used.  You're supposed to clean up the
contents before overmounting.  I discussed with viro a scheme (using
two ramfs's) which made that close to automatic, but I think he
thought it was needless complexity.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
