Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751820AbWJMTGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbWJMTGv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWJMTGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:06:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:35317 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751795AbWJMTGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:06:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=nYEd7IHkN+wUx7I7n7mhADet3/SMSzAQMsn4T8cLuYSQ6x7FjMIhsuleyDDpDVgZTiVE9Mezqw5K4MsVZMBFea0huuQhQXdcJDikKUNBGg44uvg23fptLI8I3M06klqQ1PCnqVvWlt4a0xU/JWtFmQVQzg247ea7tK+5P6wKRQI=
Reply-To: andrew.j.wade@gmail.com
To: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: Re: [PATCH 1 of 2] Stackfs: Introduce stackfs_copy_{attr,inode}_*
Date: Fri, 13 Oct 2006 15:04:11 -0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       penberg@cs.helsinki.fi, ezk@cs.sunysb.edu, mhalcrow@us.ibm.com
References: <ceb6edcac7047367ca16.1160738329@thor.fsl.cs.sunysb.edu>
In-Reply-To: <ceb6edcac7047367ca16.1160738329@thor.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610131506.38609.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 October 2006 07:18, Josef Jeff Sipek wrote:
> +static inline void stackfs_copy_inode_size(struct inode *dst,
> +					   const struct inode *src)
> +{
> +	i_size_write(dst, i_size_read((struct inode *)src));

Instead of casting, I'd change the signature of i_size_read.
