Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266466AbUALVfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266477AbUALVfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:35:33 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:46585 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266466AbUALVf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:35:28 -0500
Message-ID: <4003131E.1090408@comcast.net>
Date: Mon, 12 Jan 2004 15:35:26 -0600
From: Ian Pilcher <i.pilcher@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: initialize data not at file scope - WTF?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In include/linux/init.h, it says:

   For initialized data:
   You should insert __initdata between the variable name and equal
   sign followed by value, e.g.:

   static int init_variable __initdata = 0;
   static char linux_logo[] __initdata = { 0x32, 0x36, ... };

   Don't forget to initialize data not at file scope, i.e. within a
   function, as gcc otherwise puts the data into the bss section and not
   into the init section.

Does this mean that __initdata can't be used for file scope variables,
that it can only be used for file scope variables, or something else?

Thanks!

-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

