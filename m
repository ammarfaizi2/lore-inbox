Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289907AbSAKJYA>; Fri, 11 Jan 2002 04:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289908AbSAKJXb>; Fri, 11 Jan 2002 04:23:31 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:45834 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289907AbSAKJXV>; Fri, 11 Jan 2002 04:23:21 -0500
Date: Fri, 11 Jan 2002 12:23:15 +0300
From: Oleg Drokin <green@namesys.com>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
        adilger@turbolabs.com
Subject: Re: [reiserfs-dev] [PATCH] UUID & volume labels support for reiserfs
Message-ID: <20020111122315.B17925@namesys.com>
In-Reply-To: <20020109155504.A4551@namesys.com> <52160000.1010591279@tiny> <20020109185826.A1680@namesys.com> <100150000.1010592449@tiny> <20020109192526.A1732@namesys.com> <145590000.1010594312@tiny> <20020109194430.A2058@namesys.com> <179160000.1010596468@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179160000.1010596468@tiny>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 09, 2002 at 12:14:28PM -0500, Chris Mason wrote:

> > In fact, current reiserfsprogs understands these fields (look into the
> > the struct super_block definition in reiserfsprogs). It just cannot
> > change content of the fields.
> /* Structure of super block on disk */
> struct reiserfs_super_block
> {
> /*  0 */    struct reiserfs_super_block_v1 s_v1;
> /* 76 */    char sb_mnt_version[16];
> /* 92 */    char sb_mkfs_version[16];
> /*108 */    char sb_fsck_version[16];
> /*124 */    char sb_unused[204-16-16-16-SB_SIZE_V1] ;
> /* zero filled by mkreiserfs */ };

> Show me the part where it knows what a uuid is.  It should at least be able
> to show the uuid set by the kernel.
It does not know about uuid per se, but it know in that area some text data is stored.
(BTW, we are started to fix reiserfsprogs, so that struct superblock will be the same in kernel and in reiserfsprogs.
It is already almost close in cvs ;) )
I see MArcello have not applied this patch to 2.4.18-pre3, so we have some more time to prepare reiserfsprogs ;)

Bye,
    Oleg
