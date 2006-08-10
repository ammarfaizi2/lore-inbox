Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWHJTy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWHJTy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWHJTxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:53:49 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:23682 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932243AbWHJTxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:53:46 -0400
Message-ID: <44DB8EBE.6060003@garzik.org>
Date: Thu, 10 Aug 2006 15:53:34 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Erik Mouw <erik@harddisk-recovery.com>,
       Mingming Cao <cmm@us.ibm.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/5] Register ext3dev filesystem
References: <1155172642.3161.74.camel@localhost.localdomain> <20060810092021.GB11361@harddisk-recovery.com> <20060810175920.GC19238@thunk.org>
In-Reply-To: <20060810175920.GC19238@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Thu, Aug 10, 2006 at 11:20:22AM +0200, Erik Mouw wrote:
>> On Wed, Aug 09, 2006 at 06:17:22PM -0700, Mingming Cao wrote:
>>> Register ext4 filesystem as ext3dev filesystem in kernel.
>> Why confuse users with the name "ext3dev"? If a filesystem lives in
>> fs/blah/, it's registered as "blah" and can be mounted with "-t blah".
>> Just register the filesystem as "ext4" and mark it "EXPERIMENTAL" in
>> Kconfig.
> 
> We had this discussion on LKML.  There were those who were concerned
> that it would not be enough just to mark it be EXPERIMENTAL.

I _want_ to agree with Erik, but I must agree:  CONFIG_EXPERIMENTAL is 
pretty worthless in practice :(  It's not maintained rigorously, and 
distros _always_ enable it, because otherwise they would often omit key 
drivers that people actively use.

So, while my own personal preference would be to follow Erik's 
suggestion...  thinking realistically, an fstype change from "ext3dev" 
to "ext4" is a far more obvious-to-users method of creating a 
devel/production line of demarcation.

	Jeff



