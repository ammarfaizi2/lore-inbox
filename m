Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280569AbRKUVHf>; Wed, 21 Nov 2001 16:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281979AbRKUVH0>; Wed, 21 Nov 2001 16:07:26 -0500
Received: from [195.66.192.167] ([195.66.192.167]:60935 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280569AbRKUVHQ>; Wed, 21 Nov 2001 16:07:16 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Asm style
Date: Wed, 21 Nov 2001 23:07:03 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01112123070300.05447@manta>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using GCC 3.0.1 and seeing "multi-line literals are deprecated".
Since a patch is necessary for that (and someone submitted it already)
I'd like to hear from big kernel guys what asm statement style to use:
	asm(
"		cmd	r,r\n"
"lbl:		cmd	r,r\n"
"		cmd	r,r\n"
		: spec
		: spec
	);
[variable width for labels? I don't like it] or
	asm(
	"	cmd	r,r\n"
	"lbl:	cmd	r,r\n"
	"	cmd	r,r\n"
		: spec
		: spec
	);
[better. But \n's are ugly] or
#define NL "\n"
	asm(
	"	cmd	r,r" NL
	"lbl:	cmd	r,r" NL
	"	cmd	r,r" NL
		: spec
		: spec
	);
[I like this: \n doesn't interfere with args]
or what?
--
vda
