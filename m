Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261806AbSITJPw>; Fri, 20 Sep 2002 05:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbSITJPv>; Fri, 20 Sep 2002 05:15:51 -0400
Received: from pc-80-195-34-180-ed.blueyonder.co.uk ([80.195.34.180]:17792
	"EHLO sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261806AbSITJPv>; Fri, 20 Sep 2002 05:15:51 -0400
Date: Fri, 20 Sep 2002 10:20:52 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Seaman Hu <seaman_hu@yahoo.com>
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: What will happen when disk(ext3) is full while i continue to operate files ?
Message-ID: <20020920102052.B2585@redhat.com>
References: <20020920073927.71003.qmail@web40504.mail.yahoo.com> <20020920091114.46162.qmail@web40502.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020920091114.46162.qmail@web40502.mail.yahoo.com>; from seaman_hu@yahoo.com on Fri, Sep 20, 2002 at 02:11:14AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 20, 2002 at 02:11:14AM -0700, Seaman Hu wrote:
> Sorry. I probably didn't make it clear. 
> My system is ok when first msg "EXT3-fs error (device
> sd(8,2)) in ext3_new_inode: error 28" appears.
> However, it will crash after millions of the same msg.
> Is there some kind of buffer full to cause the crash?

Ah, that's a known problem when you run out of inodes.  Ext3
incorrectly treated it as a full fs error.  That's been fixed in -ac,
ext3 CVS and the Red Hat kernels for a while, and it's in Marcelo's
post-2.4.19 tree.

Cheers,
 Stephen
