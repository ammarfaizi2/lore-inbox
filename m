Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUAWRba (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 12:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265116AbUAWRba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 12:31:30 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:52115
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S264917AbUAWRb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 12:31:29 -0500
Date: Fri, 23 Jan 2004 12:42:24 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: =?iso-8859-1?Q?Karel_Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make in 2.6.x
Message-ID: <20040123124224.B1343@animx.eu.org>
References: <20040123145048.B1082@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: =?iso-8859-1?Q?=3C20040123145048=2EB1082=40beton=2Ecybernet=2Esrc=3E=3B_?=
 =?iso-8859-1?Q?from_Karel_Kulhav=FD_on_Fri=2C_Jan_23=2C_2004_at_02:50:48?=
 =?iso-8859-1?Q?PM_+0000?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it correct to issue "make bzImage modules modules_install"
> or do I have to do make bzImage; make modules modules_install?
> 
> Is there any documentation where I can read answer to this question?

I see nothing wrong with the first invocation, the second you should change
the ; to &&.  if make bzImage fails, it'll stop there.

I typically do all seperate like this:
make -j 20 bzImage && make -j 20 modules && make -j modules_install

Sometimes it doesn't complete, not sure why.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
