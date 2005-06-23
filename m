Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVFWTpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVFWTpB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbVFWTla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:41:30 -0400
Received: from kukac.halom.u-szeged.hu ([160.114.44.1]:20412 "EHLO
	kukac.halom.u-szeged.hu") by vger.kernel.org with ESMTP
	id S262782AbVFWTdn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:33:43 -0400
Date: Thu, 23 Jun 2005 19:33:37 +0000
From: "Kluba, Patrik" <pajko@halom.u-szeged.hu>
Subject: cryptoapi compression modules & JFFSx
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ferenc Havasi <havasi@inf.u-szeged.hu>,
       "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Michal Ludvig <michal@logix.cz>
X-Mailer: Balsa 2.3.3
Message-Id: <1119555217l.7540l.1l@detonator>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Score: -2.8 (--)
X-Scan-Signature: e70b030fb9e434ea5a14adf478f49d4a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everybody,

I'm going to port JFFS2's compression modules to CryptoApi except  
{in|de}flate, which Artem is working(?) on.
I've noticed that the pcompress thing (slen <-> *slen and partial  
compression which about a discussion was on the list) is in Herbert's  
repository. Does it mean that it will get into the kernel once? I just  
would like to be sure whether should I implement pcompress or not.

The second thing is that we would like to use CryptoApi from user  
space. This way it won't be necessary to reimplement compression  
algorithms in user space filesystem image creation programs  
(mkfs.jffsx), and it would make using & distributing closed-source  
proprietary compression methods easier.
There's a patch at http://www.logix.cz/michal/devel/cryptodev/, written  
by Michal Ludvig, which adds a /dev/crypto device for this purpose, as  
on *BSD. Is there a chance that this can get into the kernel?

Regards,

   Patrik Kluba

