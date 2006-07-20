Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbWGTX3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbWGTX3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 19:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbWGTX3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 19:29:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:45866 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030413AbWGTX33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 19:29:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pi7OHwy7K/MSkbrPAXphSDuyGt2SSizMfJHJ1PtUI4Dj3ENEkOGAxKdUbsLzHWF9bilPlTG3V5hZSQLQ4Dh9xt3439h1Sq8gx5yuWRMIe36RXb2DSZndlneThN6k0+i07OoXBOv6DkOSMCC3gFwNFtu+Rpm7b6qo2z/LYJeCSvY=
Message-ID: <195c7a900607201601m58d078pee808089b8e6b47d@mail.gmail.com>
Date: Thu, 20 Jul 2006 23:01:34 +0000
From: "roucaries bastien" <roucaries.bastien@gmail.com>
To: 7eggert@gmx.de
Subject: Re: [RFC/PATCH] revoke/frevoke system calls
Cc: "Pekka J Enberg" <penberg@cs.helsinki.fi>, alan@lxorguk.ukuu.org.uk,
       tytso@mit.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <E1G3g2H-0001W7-LB@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6AFvY-7ZK-15@gated-at.bofh.it> <E1G3g2H-0001W7-LB@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/06, Bodo Eggert <7eggert@elstempel.de> wrote:
> Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> > From: Pekka Enberg <penberg@cs.helsinki.fi>
>
> > This patch implements the revoke(2) and frevoke(2) system calls for all
> > types of files. We revoke files in two passes: first we scan all open
> > files that refer to the inode and substitute the struct file pointer in fd
> > table with NULL causing all subsequent operations on that fd to fail.
> > After we have done that to all file descriptors, we close the files and
> > take down mmaps.
>
> RFC2: Make umount -f work on local fs using this feature.
RFC3: use preliminary work about umount -f in order to get revoke for free.
See for instance
http://developer.osdl.org/dev/fumount/kernel2/patches/2.6.12/1/forced-unmount-2.6.12-1.patch
