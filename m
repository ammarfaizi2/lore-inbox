Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVEAPle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVEAPle (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 11:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVEAPle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 11:41:34 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:2398 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261655AbVEAPlb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 11:41:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nCBwSycFhc1B/miFtMQuqlALOeZxxAmibFysgxz9tZboxRF7Mpr+Kzkmd+KH7kLS3aB5az/4a0HiLy3WwDucPtABIgaxRg6owvpRZi7bKUpEcFUqE7aIGqgmW9VgGsfrxX90nOXel6BAV7x1vTe4L1v+6tyNmJDR1kHc1yC7D+I=
Message-ID: <a4e6962a05050108412c50e9b5@mail.gmail.com>
Date: Sun, 1 May 2005 10:41:30 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] private mounts
Cc: jamie@shareable.org, hch@infradead.org, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <E1DS7RB-0004Md-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050425071047.GA13975@vagabond>
	 <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu>
	 <20050430094218.GA32679@mail.shareable.org>
	 <E1DRoz9-0002JL-00@dorka.pomaz.szeredi.hu>
	 <20050430143609.GA4362@mail.shareable.org>
	 <E1DRuNU-0002el-00@dorka.pomaz.szeredi.hu>
	 <20050430164258.GA6498@mail.shareable.org>
	 <E1DRvRc-0002lq-00@dorka.pomaz.szeredi.hu>
	 <20050430235453.GA11494@mail.shareable.org>
	 <E1DS7RB-0004Md-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> As someone pointed out, CAP_SYS_ADMIN processes can already escape the
> chroot jail with CLONE_NEWNS.  (fd=open("."); clone(CLONE_NEWNS);
> [child:] fchdir(fd); chdir(".."))
> 

This really does seem like a bug.  Is there are a reason behind this
"feature", or should one of us be looking into a patch to correct
this?

Miklos you earlier suggested:
>>>How about fixing fchdir, so it checks whether you gone outside the
>>>tree under current->fs->rootmnt?  Should be fairly easy to do.

         -eric
