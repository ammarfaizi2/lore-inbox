Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319425AbSILDlf>; Wed, 11 Sep 2002 23:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319426AbSILDlf>; Wed, 11 Sep 2002 23:41:35 -0400
Received: from dsl-213-023-021-043.arcor-ip.net ([213.23.21.43]:47491 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319425AbSILDle>;
	Wed, 11 Sep 2002 23:41:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: [RFC] Raceless module interface
Date: Thu, 12 Sep 2002 05:47:57 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Neukum <oliver@neukum.name>, Roman Zippel <zippel@linux-m68k.org>,
       Alexander Viro <viro@math.psu.edu>, kaos@ocs.com.au,
       linux-kernel@vger.kernel.org
References: <20020912031345.760A32C061@lists.samba.org>
In-Reply-To: <20020912031345.760A32C061@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pKxR-0007by-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 September 2002 05:13, Rusty Russell wrote:
> B) We do not handle the "half init problem" where a module fails to load, eg.
> 	a = register_xxx();
> 	b = register_yyy();
> 	if (!b) {
> 		unregister_xxx(a);
> 		return -EBARF;
> 	}
>   Someone can start using "a", and we are in trouble when we remove
>   the failed module.

No we are not.  The module remains in the 'stopped' state
throughout the entire initialization process, as it should and
does, in my model.

-- 
Daniel
