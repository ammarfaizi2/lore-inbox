Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136478AbREGRwO>; Mon, 7 May 2001 13:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136468AbREGRwF>; Mon, 7 May 2001 13:52:05 -0400
Received: from t2.redhat.com ([199.183.24.243]:3579 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S136478AbREGRvz>; Mon, 7 May 2001 13:51:55 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE26F@orsmsx31.jf.intel.com> 
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE26F@orsmsx31.jf.intel.com> 
To: "Dunlap, Randy" <randy.dunlap@intel.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 page fault handler not interrupt safe 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Date: Mon, 07 May 2001 18:51:40 +0100
Message-ID: <12757.989257900@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


randy.dunlap@intel.com said:
> > echo "unsigned long main=0xf00fc7c8;" > f00fbug.c ; make f00fbug

> Yes, that's what the (SGI) program uses: 
> http://lwn.net/2001/0329/a/ltp-f00f.php3

Restated on l-k for the benefit of anyone naïve enough to expect me to have 
got it right... my original version would only work on the bigendian models. 
For the rest, try:

echo "unsigned main = 0xc8c70ff0;" > f00fbug.c ; make f00fbug

--
dwmw2


