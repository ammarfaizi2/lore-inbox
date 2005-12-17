Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbVLREV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbVLREV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 23:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVLREV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 23:21:27 -0500
Received: from quelen.inf.utfsm.cl ([200.1.19.194]:13518 "EHLO
	quelen.inf.utfsm.cl") by vger.kernel.org with ESMTP id S965002AbVLREV0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 23:21:26 -0500
Message-Id: <200512170017.jBH0HjSS004744@quelen.inf.utfsm.cl>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Adrian Bunk <bunk@stusta.de>, Neil Brown <neilb@suse.de>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: Re: [2.6 patch] i386: always use 4k stacks 
In-Reply-To: Message from Horst von Brand <vonbrand@inf.utfsm.cl> 
   of "Fri, 16 Dec 2005 16:03:14 -0300."
 <200512161903.jBGJ3EnR003647@quelen.inf.utfsm.cl> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date: Fri, 16 Dec 2005 21:17:45 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1

Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
[Forgot the attachment]

--=-=-=
Content-Type: text/x-c; charset=iso-8859-1
Content-Disposition: attachment; filename=tst.c
Content-Description: Example code with temporary struct on stack

struct s {
	int a, b, c;
};

void h(struct s *);

int f()
{
	struct s s;
	
	s.a = 3;
        h(&s);
}

int g()
{
        h(&((struct s) {3, 0, 0}));
}

--=-=-=
Content-Type: text/plain; charset=iso-8859-1

-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

--=-=-=--
