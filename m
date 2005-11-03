Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030540AbVKCXt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030540AbVKCXt2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbVKCXt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:49:28 -0500
Received: from mail26.sea5.speakeasy.net ([69.17.117.28]:57742 "EHLO
	mail26.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030540AbVKCXt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:49:27 -0500
Date: Thu, 3 Nov 2005 18:49:25 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Phillip Hellewell <phillip@hellewell.homeip.net>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 7/12: eCryptfs] File operations
In-Reply-To: <20051103035210.GG3005@sshock.rn.byu.edu>
Message-ID: <Pine.LNX.4.63.0511031848280.22256@excalibur.intercode>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103035210.GG3005@sshock.rn.byu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Phillip Hellewell wrote:

> +	rc = wait_event_interruptible(fl->fl_wait, !fl->fl_next);
> +	if (!rc) {
> +		goto lock_file;
> +	}

> +	} else {
> +		tempfl = posix_test_lock(file, fl);
> +	}
> +	if (!tempfl) {
> +		fl->fl_type = F_UNLCK;
> +	} else {
> +		memcpy(fl, tempfl, sizeof(struct file_lock));
> +	}

Pointless braces (all over the place).


- James
-- 
James Morris
<jmorris@namei.org>
