Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbVKDG3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbVKDG3q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 01:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbVKDG3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 01:29:46 -0500
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:48864 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1161073AbVKDG3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 01:29:45 -0500
Date: Fri, 4 Nov 2005 01:29:46 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andreas Schwab <schwab@suse.de>
cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 9/12: eCryptfs] Inode operations
In-Reply-To: <jesludp8ew.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.63.0511040123310.23744@excalibur.intercode>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103035411.GI3005@sshock.rn.byu.edu>
 <Pine.LNX.4.63.0511031850220.22256@excalibur.intercode> <jesludp8ew.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2005, Andreas Schwab wrote:

> James Morris <jmorris@namei.org> writes:
> 
> > On Wed, 2 Nov 2005, Phillip Hellewell wrote:
> >
> >> +static int grow_file(struct dentry *ecryptfs_dentry, struct file *lower_file,
> >> +		     struct inode *inode, struct inode *lower_inode)
> >> +{
> >> +	int rc = 0;
> >> +	struct file fake_file;
> >> +	memset(&fake_file, 0, sizeof(fake_file));
> >
> >
> > You don't need these initializations, bss is always initialized to zero 
> > in this environment.
> 
> Automatic variables are not related to the bss segment.

Yep, ignore whatever it was I was mis-thinking there.



- James
-- 
James Morris
<jmorris@namei.org>
