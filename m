Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161302AbWGNVE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161302AbWGNVE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 17:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161303AbWGNVE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 17:04:58 -0400
Received: from pat.uio.no ([129.240.10.4]:7832 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161302AbWGNVE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 17:04:57 -0400
Subject: Re: [PATCH -mm 5/7] add user namespace
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <m1hd1krpx6.fsf@ebiederm.dsl.xmission.com>
References: <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	 <1152815391.7650.58.camel@localhost.localdomain>
	 <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	 <1152821011.24925.7.camel@localhost.localdomain>
	 <m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>
	 <1152887287.24925.22.camel@localhost.localdomain>
	 <m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
	 <20060714162935.GA25303@sergelap.austin.ibm.com>
	 <m18xmwuo5r.fsf@ebiederm.dsl.xmission.com>
	 <1152896138.24925.74.camel@localhost.localdomain>
	 <20060714170814.GE25303@sergelap.austin.ibm.com>
	 <1152897579.24925.80.camel@localhost.localdomain>
	 <m17j2gt7fo.fsf@ebiederm.dsl.xmission.com>
	 <1152900911.5729.30.camel@lade.trondhjem.org>
	 <m1hd1krpx6.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 17:04:38 -0400
Message-Id: <1152911079.5729.70.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.56, required 12,
	autolearn=disabled, AWL 1.44, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 12:40 -0600, Eric W. Biederman wrote:
> Now I do agree if I can set the information in vfsmount and not in
> the superblock it is probably better.  But even with nfs mount superblock
> collapsing (which I almost understand) I don't see it as a real
> problem, as long as I could prevent the superblock from collapsing.

NFS is the least of your problems. You can only have one superblock for
most local filesystems too and with good reason: imagine, for instance,
the effect of having 2 different block allocators working on the same
device.

Cheers
  Trond

