Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTLEHJl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 02:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTLEHJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 02:09:41 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:46087 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S263766AbTLEHJk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 02:09:40 -0500
Date: Fri, 5 Dec 2003 09:09:29 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031205070929.GG1524@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
References: <200312041432.23907.rob@landley.net> <20031204172348.A14054@hexapodia.org> <Pine.LNX.4.58.0312050130130.2330@ua178d119.elisa.omakaista.fi> <20031205020312.GJ29119@mis-mike-wstn.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205020312.GJ29119@mis-mike-wstn.matchmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 06:03:12PM -0800, you [Mike Fedyk] wrote:
>  
>  o per file compression
>  
>  Ext2/3 has a flag for it, but support hasn't been implemented.

It has (for 2.0, 2.2, 2.4 ext2) - it just was never merged into baseline.

2.4:
http://sourceforge.net/projects/e2compr/
2.2:
http://his.luky.org/ftp/mirrors/e2compr/www.netspace.net.au/%257Ereiter/e2compr/

FWIW, I have a 2.2 server keeping >20 workstations' daily backups on
compressed ext2:

/dev/md2              441G  154G  287G  35% /backup-versioned
/dev/md4              144G  141G  3.5G  98% /backup-versioned2

and it's really solid.
  
>  o make hole support

According to Andreas Dilger, Peter Braam has implemented this (sys_punch):
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&threadm=linux.kernel.200106291838.f5TIcbAM015809%40webber.adilger.int&rnum=2&prev=/groups%3Fhl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3Dutf-8%26q%3Dhole%2Bpunch%2Bgroup%253Amlist.linux.kernel%26btnG%3DGoogle%2BSearch
  


-- v --

v@iki.fi
