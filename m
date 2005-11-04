Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030567AbVKDAYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030567AbVKDAYN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030568AbVKDAYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:24:12 -0500
Received: from mx1.suse.de ([195.135.220.2]:31469 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030567AbVKDAYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:24:11 -0500
From: Andreas Schwab <schwab@suse.de>
To: James Morris <jmorris@namei.org>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 9/12: eCryptfs] Inode operations
References: <20051103033220.GD2772@sshock.rn.byu.edu>
	<20051103035411.GI3005@sshock.rn.byu.edu>
	<Pine.LNX.4.63.0511031850220.22256@excalibur.intercode>
X-Yow: I'm having an EMOTIONAL OUTBURST!!  But, uh, WHY is there a WAFFLE
 in my PAJAMA POCKET??
Date: Fri, 04 Nov 2005 01:24:07 +0100
In-Reply-To: <Pine.LNX.4.63.0511031850220.22256@excalibur.intercode> (James
	Morris's message of "Thu, 3 Nov 2005 18:51:25 -0500 (EST)")
Message-ID: <jesludp8ew.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> writes:

> On Wed, 2 Nov 2005, Phillip Hellewell wrote:
>
>> +static int grow_file(struct dentry *ecryptfs_dentry, struct file *lower_file,
>> +		     struct inode *inode, struct inode *lower_inode)
>> +{
>> +	int rc = 0;
>> +	struct file fake_file;
>> +	memset(&fake_file, 0, sizeof(fake_file));
>
>
> You don't need these initializations, bss is always initialized to zero 
> in this environment.

Automatic variables are not related to the bss segment.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
