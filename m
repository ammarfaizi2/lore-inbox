Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbTCGLDm>; Fri, 7 Mar 2003 06:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261499AbTCGLDI>; Fri, 7 Mar 2003 06:03:08 -0500
Received: from angband.namesys.com ([212.16.7.85]:18307 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261493AbTCGLCN>; Fri, 7 Mar 2003 06:02:13 -0500
Date: Fri, 7 Mar 2003 14:12:47 +0300
From: Oleg Drokin <green@namesys.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Subject: [2.5] memleak in load_elf_binary?
Message-ID: <20030307141247.D7347@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   I am still playing with improving memleak detector thing from smatch project.

   Seems there is a memleak in fs/binfmt_elf.c::load_elf_binary() in current 2.5
   If setup_arg_pages() fails (line 638 in my sources) we do return but 
   not freeing possibly allocated elf_interpreter (line 520) and 
   allocated elf_phdata (line 500) areas.

   Is this looking real? At least it looks real for me (I am trying to get
   number of false positives way down).

Bye,
    Oleg
