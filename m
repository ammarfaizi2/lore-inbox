Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284314AbRLHJvf>; Sat, 8 Dec 2001 04:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285880AbRLHJvZ>; Sat, 8 Dec 2001 04:51:25 -0500
Received: from t2.redhat.com ([199.183.24.243]:17649 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S284314AbRLHJvN>; Sat, 8 Dec 2001 04:51:13 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.NEB.4.43.0112070005300.8687-200000@mimas.fachschaften.tu-muenchen.de> 
In-Reply-To: <Pine.NEB.4.43.0112070005300.8687-200000@mimas.fachschaften.tu-muenchen.de> 
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: Some compiler warnings in 2.4.17-pre5 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Dec 2001 09:47:56 +0000
Message-ID: <18634.1007804876@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bunk@fs.tum.de said:
>  [both jffs2 and ppp have own copies of zlib]

They have identical copies of zlib, except for a typo fix in a comment in 
the PPP version which was made after I copied it. It's probably worth 
hacking the makefiles so that only one gets built and included.

In due course, the new zlib in fs/inflate_fs will get expanded to do 
compression as well as decompression, and moved out of fs/ where it doesn't 
really belong. At that point, JFFS2 and PPP can both use that.

You could prefix all the non-static symbols in either or both of these zlib 
copies with 'ppp_' or 'jffs2_', but I prefer not to do that as it's just 
hiding the problem, not fixing it.

--
dwmw2


