Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbSK1Qep>; Thu, 28 Nov 2002 11:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbSK1Qep>; Thu, 28 Nov 2002 11:34:45 -0500
Received: from pc-62-31-66-70-ed.blueyonder.co.uk ([62.31.66.70]:35203 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S265657AbSK1Qeo>; Thu, 28 Nov 2002 11:34:44 -0500
Date: Thu, 28 Nov 2002 16:41:43 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
Message-ID: <20021128164143.D2362@redhat.com>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com> <shsptsrd761.fsf@charged.uio.no> <1038387522.31021.188.camel@ixodes.goop.org> <20021127150053.A2948@redhat.com> <15845.10815.450247.316196@charged.uio.no> <20021127205554.J2948@redhat.com> <shslm3e4or2.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <shslm3e4or2.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Nov 27, 2002 at 11:44:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 27, 2002 at 11:44:01PM +0100, Trond Myklebust wrote:

> We could possibly cache the EOF status by overloading some other field
> in the struct file. f_version comes to mind as a useful candidate,
> since it automatically gets reset by llseek.

If you want it to be preserved in cache, it needs to be in the inode,
not in the file.

--Stephen
