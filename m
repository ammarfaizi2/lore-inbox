Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290059AbSBKSj7>; Mon, 11 Feb 2002 13:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290062AbSBKSjt>; Mon, 11 Feb 2002 13:39:49 -0500
Received: from [63.231.122.81] ([63.231.122.81]:23592 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S290059AbSBKSji>;
	Mon, 11 Feb 2002 13:39:38 -0500
Date: Mon, 11 Feb 2002 11:38:48 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Patrick Mochel <mochel@osdl.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
Message-ID: <20020211113848.H9826@lynx.turbolabs.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020210004748.G9826@lynx.turbolabs.com> <Pine.LNX.4.33.0202101250150.7412-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0202101250150.7412-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Feb 10, 2002 at 12:57:11PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 10, 2002  12:57 -0800, Linus Torvalds wrote:
> On Sun, 10 Feb 2002, Andreas Dilger wrote:
> > What about BK CSET (or regular patch) submissions from non-core
> > developers?  Would you accept CSETs via email if they are preceeded
> > by a unified diff and explanation?
> 
> I have worked with a few BK patches in email, and I have to say that I
> pretty much detest them. The less I have to work with them, the better,
> although that may just because I don't yet have the same kind of
> infrastructure for them as I have for regulat patches.
>
> (But _please_ do a "bk send" to a file, and edit the file before you send
> it, instead of sending directly with that "Bitkeeper patch" subject line.
> It looks like "bk send" was really designed for automatic merges, not for
> humans)

Yes, the first time I used "bk send" to send something directly to Ted it
happened that I was offline so I looked into my mail spool at the emails
and also hated it.  What I was proposing instead of just "bk send" is to
prepend the changelog entry, a real unified diff, and gzip_uu CSET at the
end.  Larry has agreed that "bk send -d -wgzip_uu" wrapping the diff part
of the patch is a bug to be fixed.

So, instead of the current layout of "'This is a BitKeeper patch' comment +
commented-out diff + BK stuff", I would send "CSET ChangeLog + unified diff +
gzip_uu wrapped BK stuff".  This would be the output of (probably in a script):

bk changes -r<rev>
bk export -tpatch -h -du -r<rev>
bk send -wgzip_uu -r<rev> -

For example, your recent 2.5.4 release would look like the below, and I
_think_ you could just accept this with "bk receive -a [repository path]",
but I'm not sure how good the BK heuristics are for finding a CSET at the
end of a long patch.  I'm only skeptical because the current "bk send"
output comments out the diff part of the output.

ChangeSet@1.262, 2002-02-10 19:24:03-08:00, torvalds@home.transmeta.com
  update version
  TAG: v2.5.4

diff -Nru a/Makefile b/Makefile
--- a/Makefile	Mon Feb 11 10:44:32 2002
+++ b/Makefile	Mon Feb 11 10:44:32 2002
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 5
 SUBLEVEL = 4
-EXTRAVERSION =-pre6
+EXTRAVERSION =
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
This BitKeeper patch contains the following changesets:
1.262
## Wrapped with gzip_uu ##


begin 664 bkpatch3560
M'XL(`!\#:#P``[V4T6[;(!2&K\-3(/5RLG,.!H(M>5K71ENU=8V<==HMLFEL
MU;$K0[)6\L./6%U255.R1-LP<,'!1X?OY^>,WEK3)2-=5/7"=.2,?FRM2T;U
M4_,8/B^&5>-\(&M;'QBO;#>V73ZNJV;U&+!0$!^;:9>7=&TZFXPPC+8K[NG!
M)*-L^N'V\WE&2)K2BU(W"S,WCJ8I<6VWUG5AWVE7UFT3NDXW=FF<#O-VV6^W
M]@R`^4_@)`(A>Y3`)WV.!:+F:`I@7$F^RU:V2W,@%R(@CQGO47$AR"7%D$E&
M@8U]1Z`8)XPG$`6@$@"Z)S5]@S0`\I[^W<-<D)RN'@KMS("U:AORB?IBN2*S
M'402'-D(`0WD[8%BK_6]N:MJ\[+6.%(]@)K(OI"ZB'/4JA"QT&(?G->9//:(
M<8AZ%))+<JQDS_\.%*Y_+QF*/Y$,_H5D+W69T[6W1LB)I0L_:C^./2LJ$)ZX
M;R>HO+':+_:'G7:4WGM%>ZVWG[B*X@VR"1MLAE*=;#/\3S8;+N<-#;H?0_=`
M9UN:)XAQR2F2J\TT_?XU._\VS>97-U]HNGLY\]+D]W:U3/%.<B5B)#\!WOU:
%+9D%````
`
end



Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

