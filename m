Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292571AbSB0QmY>; Wed, 27 Feb 2002 11:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292785AbSB0QmN>; Wed, 27 Feb 2002 11:42:13 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:53438 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S292783AbSB0QmG>;
	Wed, 27 Feb 2002 11:42:06 -0500
Date: Wed, 27 Feb 2002 11:42:04 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Kara <jack@ucw.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Quota & XFS patch
In-Reply-To: <20020227160938.GA22460@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.GSO.4.21.0202271139480.12074-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Feb 2002, Jan Kara wrote:

>   Hello,
> 
>   I'm sending you Nathan's patch which implements things
> in quotactl interface needed for XFS. If you can remember
> the patch was already floating around some time
> ago and was generally accepted... Please apply (it will
> at least simplify patching of kernels for XFS).

Why are you leaving some copy_from_user() in methods?  Either the structures
you are passing are fs-independent and everybody would be better off with
having them copied in one place or they are not, and then API is completely
broken.

