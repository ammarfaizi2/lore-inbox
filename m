Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbTBDVnv>; Tue, 4 Feb 2003 16:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267467AbTBDVnv>; Tue, 4 Feb 2003 16:43:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17679 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267458AbTBDVnu>; Tue, 4 Feb 2003 16:43:50 -0500
Message-ID: <3E403635.9050303@zytor.com>
Date: Tue, 04 Feb 2003 13:52:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: isofs hardlink bug (inode numbers different)
References: <20030126235556.GA5560@paradise.net.nz> <b1nd5m$rhp$1@cesium.transmeta.com> <20030204212812.GA32465@iapetus.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen wrote:
> 
> Suppose that the root of a iso9660 has entries such as '/', '.' and '..'
> all with inode 2 and maybe that there are  some other indications that
> the creator applied UNIX style inode numbering, wouldn't it be reasonable
> to assume that inode numbers should be trusted?
> 

The thing is, RockRidge attributes are a file-by-file thing.  You can
have it on half the files if you want.

Of course, since Linux isn't dependent on the inode numbers to find the
directory entries anymore (since we now have dentries), one could
rewrite the iso9660 filesystem so that it doesn't matter.  This is a
major rewrite, however.  It wouldn't be unwelcome; the current code is
pretty awful.

	-hpa

