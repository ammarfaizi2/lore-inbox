Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317352AbSGZHyB>; Fri, 26 Jul 2002 03:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSGZHyB>; Fri, 26 Jul 2002 03:54:01 -0400
Received: from gate.in-addr.de ([212.8.193.158]:26125 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S317352AbSGZHyA>;
	Fri, 26 Jul 2002 03:54:00 -0400
Date: Fri, 26 Jul 2002 09:57:05 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020726075705.GB11423@marowsky-bree.de>
References: <20020725205910.GR1180@dualathlon.random> <Pine.LNX.4.44L.0207251941120.3086-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L.0207251941120.3086-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-07-25T19:41:39,
   Rik van Riel <riel@conectiva.com.br> said:

> > valuable for what? you need the system.map or the .o disassembly of the
> > module anyways to take advantage of such symbol. I don't find it useful.
> If you're willing to teach all our users how to use ksymoops ... ;)

Andrea is comeing from the background that he has an archive with all binary
images and all vmlinux ever shipped available. So if he gets such an Oops with
the start address of all loaded modules and a unique id of which kernel was
used, a specially modified ksymoops can reliably decode the Oops.

This is a desireable feature in any case and just should be done.

However, it doesn't help people with self-compiled kernels; while some support
contracts have a notice attached that such kernels invalidate all contracts,
certifications and maintenance ;), we all know that such kernels are fairly
common place; and the support staff would need to keep track of every single
kernel image ever approved for customer use.

This is where kksymoops and Cort's patch would come in very handy and I do
strongly believe that they should be included in the default kernel, or at
least in the vendor ones, and their should be a strong suggestion to enable
this feature for all self-compiled kernels.

It is good to see that such patches are at least being considered for
inclusion now; the mainstream-kernel has an amazing lack of debugging features
;-) (Yes, I recall the discussions and the arguments about this topic since
1.0.x)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

