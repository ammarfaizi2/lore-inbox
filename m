Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312998AbSELMXL>; Sun, 12 May 2002 08:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313012AbSELMXK>; Sun, 12 May 2002 08:23:10 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:13837 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312998AbSELMXK>;
	Sun, 12 May 2002 08:23:10 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre8-ac2 kbuild 2.4 tmp_include_depends 
In-Reply-To: Your message of "Sun, 12 May 2002 12:39:46 +0200."
             <20020512103946.GB3749@louise.pinerecords.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 May 2002 22:22:59 +1000
Message-ID: <22944.1021206179@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002 12:39:46 +0200, 
Tomas Szepe <szepe@pinerecords.com> wrote:
>> [Keith Owens <kaos@ocs.com.au>, May-12 2002, Sun, 20:11 +1000]
>> Missed one occurrence of .tmp_include_depends.  Edit Makefile, find
>> $(patsubst %, _dir_%, $(SUBDIRS)) and change .tmp_include_depends to
>> tmp_include_depends (no '.' at start).
>> 
>> Corrected patch against 2.4.19-pre8-ac2.
>
>Great work, Keith!
>"make modules_install" takes like 2 seconds w/ -ac now!

That was not the aim (although I will accept the praise :).  The patch
ensures that cross directory header dependencies are done correctly on
kbuild 2.4.  Any speed up as a side effect of removing .hdepend from
Rules.make is a bonus.

kbuild mantra - correctness first, speed second.

