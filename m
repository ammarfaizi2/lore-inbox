Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269014AbUICDss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269014AbUICDss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 23:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268857AbUICDqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 23:46:53 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:9189 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S268415AbUICDpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 23:45:08 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "J.A. Magallon" <jamagallon@able.es>
Date: Fri, 3 Sep 2004 13:44:59 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16695.59579.815974.319039@cse.unsw.edu.au>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: buildin a RAID5 md vith 6 drives
In-Reply-To: message from J.A. Magallon on Friday September 3
References: <1094172896l.17931l.2l@werewolf.able.es>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday September 3, jamagallon@able.es wrote:
> Hi all...
> 
> I tried to build a RAID5 array with 6 drivres, just with:
...
> Why does it think a drive has been removed, and the last drive is a spare ?
> Isn't raid5 symmetric over all drives ?

Read 
  man mdadm
the section on "CREATE MODE", the last paragraph before the "General
Management options" are listed.  Be sure that you have mdadm 1.4.0 or
later.

NeilBrown


[ the paragraph reads:
       When creating a RAID5 array, mdadm will automatically create a degraded
       array  with  an  extra spare drive.  This is because building the spare
       into a degraded array is in general faster than resyncing the parity on
       a  non-degraded, but not clean, array.  This feature can be over-ridden
       with the --force option.
if you remove the "-I" that really shoudn't be there... :-(
]




> 
> TIA
> 
> --
> J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
> werewolf!able!es                         \         It's better when it's free
> Mandrakelinux release 10.1 (Beta 1) for i586
> Linux 2.6.8.1-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #8
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
