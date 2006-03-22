Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWCVTHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWCVTHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWCVTHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:07:34 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:9515 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932344AbWCVTHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:07:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=hdN74NsNe36cXhq6j1xhzenfEYGHWsBGb7WKGbyKea2egnH7zAxCc/46aBC95VipWR3QCy+yupUJkevQymMYTpUZgzQJc5g3L/AC0IxJlJYVYBILbYElyI/yMnbMZgUo1XQSU83C4MyLzwQkSzf1sSNBJsytJRIYzU0lCSPqVWo=
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time
	through fs-wide dirty bit]
From: Badari Pulavarty <pbadari@gmail.com>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjan@linux.intel.com>,
       "Theodore Ts'o" <tytso@mit.edu>, Zach Brown <zach.brown@oracle.com>
In-Reply-To: <20060322011034.GP12571@goober>
References: <20060322011034.GP12571@goober>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 11:09:18 -0800
Message-Id: <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 17:10 -0800, Valerie Henson wrote:
> Hi all,
> 
> I am working on reducing the average time spent on fscking ext2 file
> systems.  My initial take on the problem is to avoid fscking when the
> file system is not being modified.  If we're not actively modifying
> the file system when we crash, it seems intuitive that we could avoid
> fsck on next mount.  The obvious way to implement this is to add a
> clean/dirty bit to the superblock, check every so often to see if the
> file system is not being written, sync out all outstanding writes, and
> mark the file system clean.  On boot, fsck should check for the clean
> bit and mark the file system as valid, thereby avoiding a full fsck.
> I call this the fs-wide dirty bit solution.
..

Just curious, why are you teaching ext2 same tricks that are in ext3 ?
Is there a reason behind improving ext2 ? Are there any benefits
of not using ext3 instead ?

Thanks,
Badari

