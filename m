Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbUK3RAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbUK3RAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUK3Q6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:58:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37514 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262198AbUK3Q5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:57:13 -0500
Date: Tue, 30 Nov 2004 11:56:45 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Gerrit Huizenga <gh@us.ibm.com>
cc: linux-kernel@vger.kernel.org, <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] [PATCH] CKRM: 6/10 CKRM:  Resource controller for
 sockets
In-Reply-To: <E1CYqax-000591-00@w-gerrit.beaverton.ibm.com>
Message-ID: <Xine.LNX.4.44.0411301152550.12330-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004, Gerrit Huizenga wrote:


> Index: linux-2.6.10-rc2-ckrm1/include/net/sock.h
> ===================================================================
> --- linux-2.6.10-rc2-ckrm1.orig/include/net/sock.h	2004-11-14 17:28:14.000000000 -0800
> +++ linux-2.6.10-rc2-ckrm1/include/net/sock.h	2004-11-24 12:33:23.000000000 -0800
> @@ -249,6 +249,7 @@
>  	struct timeval		sk_stamp;
>  	struct socket		*sk_socket;
>  	void			*sk_user_data;
> +	void			*sk_ns; // For use by CKRM
>  	struct module		*sk_owner;
>  	struct page		*sk_sndmsg_page;
>  	__u32			sk_sndmsg_off;
> 

Why is this a void pointer?  Seems like it is only ever used for struct
ckrm_net_struct.  Also, please call it something obviously ckrm related
and it won't need the comment. (And why put the comment there anyway when
the other fields are documented in a comment block above?)


- James
-- 
James Morris
<jmorris@redhat.com>


