Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268482AbUHLSel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268482AbUHLSel (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 14:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268491AbUHLSei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 14:34:38 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:33240 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268482AbUHLSee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 14:34:34 -0400
Message-ID: <411C60EA.EA01F2A2@us.ibm.com>
Date: Fri, 13 Aug 2004 01:34:19 -0500
From: "Steve French (IBM LTC)" <smfltc@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Nuno Ferreira <nuno.ferreira@graycell.biz>
CC: linux-cifs-client@lists.samba.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Process hangs copying large file to cifs
References: <1088459930.5666.8.camel@stevef95.austin.ibm.com>
		 <1088507544.2418.1.camel@taz.graycell.biz> <1092328302.4172.42.camel@taz.graycell.biz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your log entries indicate that the socket was dead, so the patch you hand applied for hashing of inodes
appears unrelated.   Many (including myself copy) much larger files regularly via CIFS.   I don't know
whether the best approach is to backport the other fixes that could affect this code path to your kernel
so we can see if this is a current problem in some recovery path or has already been fixed.   There are
only three to four global changes in the kernel (that hit the fs/cifs directory) since 2.6.6 that would
have to be dealt with to compile the current 2.6.8 fs/cifs directory on an older 2.6.6 kernel.

Nuno Ferreira wrote:

> On Ter, 2004-06-29 at 12:12 +0100, Nuno Ferreira wrote:
> > On Seg, 2004-06-28 at 16:58 -0500, Steve French wrote:
> > > >  > This is copying a 197Mb from an my laptop's IDE hardisk to a cifs
> > > > mounted share that's on a Win2000 Server
> > >
>

