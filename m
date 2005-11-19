Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVKSKuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVKSKuR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 05:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVKSKuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 05:50:17 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:4813 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751099AbVKSKuP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 05:50:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hw6FVYr8y7eVvVTFRboPhufyQPkUOAI1FJTuPjrdTnWUnM3kQjcC6VzYC3Y30vQfFAez+gwhn88/bwdub2YA9u516LrPnsblB+n5THCVh1ELIkfOAPNLSODbkNM8oW/E/I7DOcN7bvoqIFjENup1DSbh0CpeH6qHvnizlCZGeHU=
Message-ID: <84144f020511190250x2efdbfb4vf33245b3f7216fe5@mail.gmail.com>
Date: Sat, 19 Nov 2005 12:50:13 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Subject: Re: [PATCH 6/12: eCryptfs] Superblock operations
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
In-Reply-To: <20051119041910.GF15747@sshock.rn.byu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051119041130.GA15559@sshock.rn.byu.edu>
	 <20051119041910.GF15747@sshock.rn.byu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/05, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> +/**
> + * This is called through iput_final().
> + * This is function will replace generic_drop_inode. The end result of which
> + * is we are skipping the check in inode->i_nlink, which we do not use.
> + */
> +static void ecryptfs_drop_inode(struct inode *inode) {
> +       generic_delete_inode(inode);
> +}

Please drop this useless wrapper and introduce it when it actually
does something.

                           Pekka
