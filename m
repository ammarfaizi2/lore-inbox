Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130417AbRCBMBg>; Fri, 2 Mar 2001 07:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130418AbRCBMB0>; Fri, 2 Mar 2001 07:01:26 -0500
Received: from colargol.tihlde.hist.no ([158.38.48.10]:51986 "HELO
	colargol.tihlde.org") by vger.kernel.org with SMTP
	id <S130417AbRCBMBN>; Fri, 2 Mar 2001 07:01:13 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: Alexander Viro <viro@math.psu.edu>, "H. Peter Anvin" <hpa@transmeta.com>,
        Bill Crawford <billc@netcomuk.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
In-Reply-To: <3A9EB984.C1F7E499@transmeta.com>
	<Pine.GSO.4.21.0103011608360.11577-100000@weyl.math.psu.edu>
	<20010302100410.I15061@atrey.karlin.mff.cuni.cz>
From: Oystein Viggen <oysteivi@tihlde.org>
Organization: Tihlde
X-URL: http://www.tihlde.org/~oysteivi/
X-Phone-Number: +47 97 11 48 58
X-Address: Tordenskioldsgt. 12, 7012 Trondheim, Norway
X-MSMail-Priority: High
X-Face: R=b-K(^1#]KR?6moG:Wrc/t>p)?p`?bgHg36M3hZ>^?\akat3!nX*8xZpIvZrI#]ZzN`I<+
 L{8#pdH*1SOB$Zu-_e1<>iE$5cGiLhRem.ct.QtE=&v@9\S_6slX4='![%,F3^&ed5Y5g-#!N'Lr[s
 &Gfs3c}pYq^oUo{8l-qD87s[P1~+f([41~gD}Pj)nX|KcVv;tF4IIx%pnN\UL|SNT
Date: 02 Mar 2001 13:01:09 +0100
In-Reply-To: <20010302100410.I15061@atrey.karlin.mff.cuni.cz>
Message-ID: <03ofvkcrcq.fsf@colargol.tihlde.hist.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote: 

> xargs is very ugly. I want to rm 12*. Just plain "rm 12*". *Not* "find
> . -name "12*" | xargs rm, which has terrible issues with files names
> 
> "xyzzy"
> "bla"
> "xyzzy bla"
> "12 xyzzy bla"

These you work around using the smarter, \0 terminated, version:

find . -name "12*" -print0 | xargs -0 rm

"This version would also deal with
 this filename  ;)"

Oystein
-- 
ssh -c rot13 otherhost
