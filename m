Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262193AbSJNXFV>; Mon, 14 Oct 2002 19:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262226AbSJNXFV>; Mon, 14 Oct 2002 19:05:21 -0400
Received: from host194.steeleye.com ([66.206.164.34]:36365 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262193AbSJNXFV>; Mon, 14 Oct 2002 19:05:21 -0400
Message-Id: <200210142311.g9ENB9m04835@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: [PATCH] Summit support for 2.5 - now with subarch! [4/5]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Oct 2002 16:11:09 -0700
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +       summit_check(oem, str);

This is more a type check hook.  Since it might potentially be used to catch 
other machine types, shouldn't it have a more generic name 
(mptable_string_hook or something)?

> +int summit_x86 = 0;

This should really be in a .c file in mach-summit.  I know a single line file 
with just a variable in it is a bit strange, but the principle of the subarch 
stuff is to have anything subarch specific (which this is) in mach-<subarch>.

James


