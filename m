Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTJSILg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 04:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTJSILg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 04:11:36 -0400
Received: from dns.datafoundation.com ([209.150.125.194]:27296 "EHLO
	duellist.datafoundation.com") by vger.kernel.org with ESMTP
	id S262074AbTJSILe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 04:11:34 -0400
Date: Sun, 19 Oct 2003 04:11:32 -0400 (EDT)
From: "Nikita U. Shulga" <nikita@datafoundation.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8: arch/i386/kernel/microcode.c compilation problems
Message-ID: <Pine.LNX.4.44.0310190410500.29790-100000@duellist.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

After applying 2.6.0-test8 patch, I were failed to compile kernel, because 
of changes in microcode.c
In function find_matching_ucodes() , line 326 written:
       int ext_table_sum = 0;
       i = ext_table_size / DWSIZE;
       int * ext_tablep = (((void *) newmc) + MC_HEADER_SIZE + data_size);

This is threated as error by gcc-2.95.3. But if you simple exchange second 
and third line, microcode.c became compilable by this version of GCC.

Is there any "preferred" version of gcc, which I should you to build 
kernel?
Hope I don.t bother you too much with this mess....
Nikita


