Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVADDjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVADDjf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 22:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVADDjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 22:39:35 -0500
Received: from lakermmtao01.cox.net ([68.230.240.38]:36091 "EHLO
	lakermmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262000AbVADDjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 22:39:31 -0500
In-Reply-To: <16858.1074.740440.917427@samba.org>
References: <41D9C635.1090703@zytor.com> <16857.56805.501880.446082@samba.org> <41D9E3AA.5050903@zytor.com> <16857.59946.683684.231658@samba.org> <41D9EDF6.1060600@zytor.com> <16857.62250.259275.305392@samba.org> <41D9F65E.3030301@zytor.com> <16857.63978.65838.823252@samba.org> <AA7F1C76-5DF7-11D9-B689-000393ACC76E@mac.com> <16858.1074.740440.917427@samba.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3D55717A-5E02-11D9-B689-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: sfrench@samba.org, samba-technical@lists.samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
Date: Mon, 3 Jan 2005 22:39:29 -0500
To: tridge@samba.org
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 03, 2005, at 21:49, tridge@samba.org wrote:
> The important thing is that if your file access is either only from
> unix apps that know about posix ACLs or only from windows apps that
> know about NT ACLs, then you need to provide perfect lossless storage
> of those native ACLs for those applications. It is only when you get a
> transition from one scheme to the other on the one file that a mapping
> should happen.

I was thinking something more along the lines of a more complex and
detailed scheme that is a superset of both NT ACLs and POSIX ACLs.
Then that scheme could be used for DAC within the kernel, although it
would still continue to support operations using the POSIX API by
translating losslessly from POSIX to "Linux", although it might not work
the other way around.  Such an ACL would need to be well designed
internally to be compatible with future ACL structures and such, but it
would make your work a lot easier.  There will always be data loss
when translating between incompatible formats, but if we can come up
with some kind of system that can handle both data-sets losslessly,
then we could have the VFS use that, even if the only programs that
understand it are the ACL tools.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


