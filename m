Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288828AbSAIRP4>; Wed, 9 Jan 2002 12:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288787AbSAIRPk>; Wed, 9 Jan 2002 12:15:40 -0500
Received: from 216-42-72-144.ppp.netsville.net ([216.42.72.144]:60368 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S288246AbSAIRPB>; Wed, 9 Jan 2002 12:15:01 -0500
Date: Wed, 09 Jan 2002 12:14:28 -0500
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>
cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, adilger@turbolabs.com
Subject: Re: [reiserfs-dev] [PATCH] UUID & volume labels support for
 reiserfs
Message-ID: <179160000.1010596468@tiny>
In-Reply-To: <20020109194430.A2058@namesys.com>
In-Reply-To: <20020109155504.A4551@namesys.com> <52160000.1010591279@tiny>
 <20020109185826.A1680@namesys.com> <100150000.1010592449@tiny>
 <20020109192526.A1732@namesys.com> <145590000.1010594312@tiny>
 <20020109194430.A2058@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, January 09, 2002 07:44:30 PM +0300 Oleg Drokin
<green@namesys.com> wrote:

> Does filling something with zeroes counts as "using the field"? ;)

We must be reading different versions of generate_random_uuid ;-)

> 
>> The point is that we should never add something to the kernel until our
>> utils package understands it.  Yes, this is a simple case, but if we want
> In fact, current reiserfsprogs understands these fields (look into the
> the struct super_block definition in reiserfsprogs). It just cannot
> change content of the fields.

/* Structure of super block on disk */
struct reiserfs_super_block
{
/*  0 */    struct reiserfs_super_block_v1 s_v1;
/* 76 */    char sb_mnt_version[16];
/* 92 */    char sb_mkfs_version[16];
/*108 */    char sb_fsck_version[16];
/*124 */    char sb_unused[204-16-16-16-SB_SIZE_V1] ;
/* zero filled by mkreiserfs */ };

Show me the part where it knows what a uuid is.  It should at least be able
to show the uuid set by the kernel.

Please don't take this the wrong way, this is a good (and simple) patch
that adds a cool feature.  We just need to do a better job of having the
utils support the features before sending the patch it.  It does a better
job of proving we've tested the feature and that kernel patch fully meets
our needs.

-chris

