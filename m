Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269777AbUJAMse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269777AbUJAMse (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 08:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269775AbUJAMse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 08:48:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31448 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269785AbUJAMpm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 08:45:42 -0400
Date: Fri, 1 Oct 2004 13:45:41 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Stephen Tweedie <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [Patch 6/10]: ext3 online resize: remove on-stack bogus inode
Message-ID: <20041001124541.GB16153@parcelfarce.linux.theplanet.co.uk>
References: <200409301323.i8UDNjwG004790@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409301323.i8UDNjwG004790@sisko.scot.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 02:23:45PM +0100, Stephen Tweedie wrote:
> Remove the "bogus" on-stack inode.  It's only used as a marker for
> indirectly passing the sb to various functions, so also add
> ext3_journal_start_sb() which starts a transaction for a given
> super_block rather than for an inode.
> 
> --- linux-2.6.9-rc2-mm4/fs/ext3/resize.c.=K0005=.orig
> +++ linux-2.6.9-rc2-mm4/fs/ext3/resize.c
> @@ -159,7 +159,7 @@ static void mark_bitmap_end(int start_bi
>   *
>   * We only pass inode because of the ext3 journal wrappers.
>   */

Should probably update the comment too ;-)

(who was it said inline documentation gets updated when the code does?  ;-P)

> @@ -616,7 +616,7 @@ exit_free:
>   *
>   * We only pass inode because of the ext3 journal wrappers.
>   */

Same here.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
