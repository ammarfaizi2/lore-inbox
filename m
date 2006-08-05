Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWHESgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWHESgN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 14:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWHESgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 14:36:13 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:380 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751388AbWHESgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 14:36:12 -0400
Date: Sat, 5 Aug 2006 11:36:09 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Valerie Henson <val_henson@linux.intel.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>, jsipek@cs.sunysb.edu,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] [PATCH] Relative lazy atime
Message-ID: <20060805183609.GA7564@tuatara.stupidest.org>
References: <20060803063622.GB8631@goober> <20060805122537.GA23239@lst.de> <1154797123.12108.6.camel@kleikamp.austin.ibm.com> <1154797475.3054.79.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154797475.3054.79.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 07:04:34PM +0200, Arjan van de Ven wrote:

> the vfs shouldn't consider it clean, it should consider it
> "atime-only dirty".. with that many of the vfs interaction issues
> ought to go away

should it be atime-dirty or non-critical-dirty? (ie. make it more
generic to cover cases where we might have other non-critical fields
to flush if we can but can tolerate loss if we dont)

adminitedly atime is the only one i can think of now
