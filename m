Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268578AbUIHP6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268578AbUIHP6h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 11:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268368AbUIHP6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 11:58:03 -0400
Received: from imf24aec.mail.bellsouth.net ([205.152.59.72]:62596 "EHLO
	imf24aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S267568AbUIHP4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 11:56:46 -0400
Date: Wed, 8 Sep 2004 10:56:50 -0500
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: linux-kernel@vger.kernel.org
Subject: Re: proc stalls
Message-Id: <20040908105650.398e951a.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <20040908141848.GB21729@washoe.rutgers.edu>
References: <20040908054101.GR2966@washoe.rutgers.edu>
	<20040908141848.GB21729@washoe.rutgers.edu>
X-Mailer: Sylpheed version 0.9.12cvs7 (GTK+ 1.2.10; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uttered Yaroslav Halchenko <yoh@psychology.rutgers.edu>, spake thus:

> that problem was linked to the fact that nfs-mounted directory became
> unavailable... 
> Any ideas on how to further debug this situation to avoid future
> problems?

This is the required behavior for "hard" NFS mounts.  NFS doesn't
deal with servers that drop off-line very well.

Perhaps you should use the "soft" and/or the "timeo=N" value.  A
"soft" mount will not cause your client to hang if the server goes
away.  Unfortunately, this also has implications for application
program's ideas about file integrity, but there you go.

HTH.
