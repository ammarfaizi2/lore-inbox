Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264833AbSKEMTA>; Tue, 5 Nov 2002 07:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbSKEMTA>; Tue, 5 Nov 2002 07:19:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32199 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264833AbSKEMSy>;
	Tue, 5 Nov 2002 07:18:54 -0500
Date: Tue, 5 Nov 2002 07:25:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Samium Gromoff <_deepfire@mail.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] FS charset conversions
In-Reply-To: <E1891J9-000B9X-00@f15.mail.ru>
Message-ID: <Pine.GSO.4.21.0211050720220.2336-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Nov 2002, Samium Gromoff wrote:

>         The problem root lies in the fact in some languages (notably russian)
>     there is more then one widely used charset. In russian for example
>     there are koi8-r, iso8859-5, cp866 and the infamous but widely used
>     ms cp1251.
> 
>         Once you need to have access to some data with names using the second
>     half of the ascii table the trouble arises. For example the situation
>     i have here is that smbd provides the public share and people creates
>     there some files originating with the cp1251 encoding. Myself having
>     koi8-r as the system default charset naturally observe crap.
> 
>         The proposed and seemingly natural solution is to add a possibility
>     to mount --bind the subtree with a filename charset conversion applied.

Will not work.  Bindings do _NOT_ create extra superblock/dentry tree/etc.
and they are invisible to filesystem.  E.g. to ->readdir().

(besides, filesystems playing with case conversions are bad enough, now
let's VFS try charset ones?)

