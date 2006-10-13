Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWJMIxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWJMIxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 04:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWJMIxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 04:53:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:26040 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750971AbWJMIxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 04:53:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ERGg9yy48rn0yyLniu1YVD3r39zlUVqitJs/nWfBkBLyHTezHl7bcQ3Lv3KdK/1MGhgiJechthZPdGq3RFWpjpvXFHKpwr9WQs0z9F7cMIqYnvo1+GVrkjL1QaTLD3+5MP6+IIgqD1ViPYp2ARzodbbttXopKW7JQjH33EZkiTw=
Message-ID: <84144f020610130153q75e34eefg5858f9345e335063@mail.gmail.com>
Date: Fri, 13 Oct 2006 11:53:09 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Josef Jeff Sipek" <jsipek@cs.sunysb.edu>
Subject: Re: [PATCH 10 of 23] Unionfs: Inode operations
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk
In-Reply-To: <4396cbf3c30212755fff.1160197649@thor.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
	 <4396cbf3c30212755fff.1160197649@thor.fsl.cs.sunysb.edu>
X-Google-Sender-Auth: 53bc8a879f33a748
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/06, Josef Jeff Sipek <jsipek@cs.sunysb.edu> wrote:
> +static int unionfs_setattr(struct dentry *dentry, struct iattr *ia)
> +{

[snip]

> +       for (bindex = bstart; (bindex <= bend) || (bindex == bstart); bindex++) {

But everywhere else we have

>        for (bindex = bstart; bindex <= bend; bindex++) {

Hmm?

P.S. for_each_branch() and for_each_branch_reverse() might be a good idea.

                                       Pekka
