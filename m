Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbVAKWJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVAKWJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbVAKWHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:07:00 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:25499 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262901AbVAKWF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:05:27 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Lincoln Dale <ltd@cisco.com>
Date: Wed, 12 Jan 2005 09:02:35 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16868.19707.857446.864762@cse.unsw.edu.au>
Cc: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux NFS vs NetApp
In-Reply-To: message from Lincoln Dale on Tuesday January 11
References: <message from Phy Prabab on Monday January 10>
	<20050111025401.48311.qmail@web51810.mail.yahoo.com>
	<5.1.0.14.2.20050111223726.044844e8@171.71.163.14>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 11, ltd@cisco.com wrote:
> At 08:54 PM 11/01/2005, Neil Brown wrote:
> >If you want to come anything close to comparable with a Netapp, get a
> >few hundred Megabytes of NVRAM (e.g. www.umem.com), and configure it
> >as an external journal for your filesystem (I know this can be done
> >for ext3, I don't know about other filesystems).  Then make sure your
> >filesystem journals all data, not just metadata (data=journal option
> >to ext3).
> 
> NetApp's WAFL only journals metadata in NVRAM ...
> (one of the primary reasons its called WAFL is that the data-write only 
> happens once..).
> 

That may be, though it doesn't fit with my (admittedly limitted)
understanding of WAFL.

However Linux NFS definitely runs faster over ext3 if data=journal is
selected.

NeilBrown
