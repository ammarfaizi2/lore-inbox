Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWGAXMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWGAXMZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 19:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWGAXMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 19:12:25 -0400
Received: from terminus.zytor.com ([192.83.249.54]:32927 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751428AbWGAXMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 19:12:24 -0400
Message-ID: <44A7011B.6000702@zytor.com>
Date: Sat, 01 Jul 2006 16:11:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Miles Lane <miles.lane@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined
 reference to `__stack_chk_fail'
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com> <1151788673.3195.58.camel@laptopd505.fenrus.org> <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com> <1151789342.3195.60.camel@laptopd505.fenrus.org> <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com> <a44ae5cd0607011556t65b22b06m317baa9a47ff962@mail.gmail.com> <20060701230635.GA19114@mars.ravnborg.org>
In-Reply-To: <20060701230635.GA19114@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> 
> For klibc you need to patch scripts/Kbuild.klibc
> 
> Appending it to KLIBCWARNFLAGS seems the right place.

KLIBCREQFLAGS, rather.

> Do you know from what gcc version we can start using -fno-stack-protector?

Isn't there a macro to test if gcc supports a specific option already?

Either way, I can also add __stack_chk_fail() as an alias for abort(), 
for people who actually want the feature.

	-hpa

