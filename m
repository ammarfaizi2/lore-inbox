Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVLGJiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVLGJiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 04:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVLGJiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 04:38:11 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:10598 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750744AbVLGJiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 04:38:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=GD/sTSxexWuxT19uu0BbT6tumxQ3oPTcSZodvjAYXBNNac6izysf/MFllUizEyqXedJv+aYML7c/KWvkiKgyj6jlPB3BDHlW1L2/1yGrgyh7dZ6ljfHlwkm4k8MOKWObsU13BLY69qH6CTO7116LkUx7ZVmTIm7E4BntApIkQkI=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: fix compile error for tt
Date: Wed, 7 Dec 2005 10:38:04 +0100
User-Agent: KMail/1.8.3
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jdike@karaya.com
References: <1133900650.3279.9.camel@localhost>
In-Reply-To: <1133900650.3279.9.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071038.04958.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 December 2005 21:24, Pekka Enberg wrote:
> Without the included patch, I get the following compile error for um:
>
> arch/um/kernel/tt/uaccess.c: In function `copy_from_user_tt':
> arch/um/kernel/tt/uaccess.c:11: error: `FIXADDR_USER_START' undeclared
> (first use in this function) arch/um/kernel/tt/uaccess.c:11: error: (Each
> undeclared identifier is reported only once arch/um/kernel/tt/uaccess.c:11:
> error: for each function it appears in.)
>
> The error only happens when I disable CONFIG_MODE_SKAS.
Ok, fine, just a note - the header inclusion should be added to 

arch/um/include/um_uaccess.h

where it is effectively used (the offending macros, using FIXADDR_USER_*, are 
__access_ok_vsyscall.

For the rest it's ok.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
