Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVCHD3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVCHD3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVCGUWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:22:51 -0500
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20]:5255 "EHLO
	pc18.dolda2000.com") by vger.kernel.org with ESMTP id S261519AbVCGTsj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:48:39 -0500
Subject: Missing include file in linux/ixjuser.h
From: Fredrik Tolf <fredrik@dolda2000.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 07 Mar 2005 20:48:37 +0100
Message-Id: <1110224917.32443.17.camel@pc7.dolda2000.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There's a problem in the include/linux/ixjuser.h file. It uses the
__user macro, but doesn't include the linux/compiler.h file. This
doesn't seem to be a problem for the kernel (I'm guessing since some
other file includes compiler.h), but it makes a difference when
compiling user-space programs that uses ixjuser.h.

Including linux/compiler.h in ixjuser.h solves the problem.

Fredrik Tolf


