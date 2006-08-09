Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWHIM60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWHIM60 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWHIM60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:58:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:16293 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750737AbWHIM6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:58:25 -0400
Subject: Re: [RFC] [PATCH] Relative lazy atime
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Valerie Henson <val_henson@linux.intel.com>,
       Matthew Wilcox <matthew@wil.cx>, dean gaudet <dean@arctic.org>,
       David Lang <dlang@digitalinsight.com>,
       Mark Fasheh <mark.fasheh@oracle.com>, Chris Wedgwood <cw@f00f.org>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Akkana Peck <akkana@shallowsky.com>,
       Jesse Barnes <jesse.barnes@intel.com>, jsipek@cs.sunysb.edu,
       Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <20060809122134.GF27863@wohnheim.fh-wedel.de>
References: <20060803063622.GB8631@goober> <20060805122537.GA23239@lst.de>
	 <1154797123.12108.6.camel@kleikamp.austin.ibm.com>
	 <1154797475.3054.79.camel@laptopd505.fenrus.org>
	 <20060805183609.GA7564@tuatara.stupidest.org>
	 <20060805222247.GQ29686@ca-server1.us.oracle.com>
	 <Pine.LNX.4.63.0608051604420.20114@qynat.qvtvafvgr.pbz>
	 <Pine.LNX.4.64.0608051612330.20926@twinlark.arctic.org>
	 <20060806030147.GG4379@parisc-linux.org> <20060809063947.GA13474@goober>
	 <20060809122134.GF27863@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 09 Aug 2006 07:58:20 -0500
Message-Id: <1155128301.10228.2.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 14:21 +0200, Jörn Engel wrote:
> 1. standard
> Every read access to a file/directory causes an atime update.
> 
> 2. nodiratime
> Every read access to a non-directory causes an atime update.
> 
> 3. lazy atime
> The first read access to a file/directory causes an atime update.
> 
> 4. noatime
> No read access to a file/directory causes an atime update.
> 
> In comparison, lazy atime will cause more atime updates for
> directories and vastly fewer for non-directories.

Using nodiratime and lazy atime together would probably be the best
option for those that only want atime for mutt/shell mail notification.

>  Effectively atime
> is turned into little more than a flag, stating whether the file was
> ever read since the last write to it.  And it appears as if neither
> mutt nor the shell use atime for more than this flagging purpose, so I
> am rather fond of the idea.
> 
> Jörn
> 
-- 
David Kleikamp
IBM Linux Technology Center

