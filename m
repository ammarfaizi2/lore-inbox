Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268190AbTALAzS>; Sat, 11 Jan 2003 19:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268191AbTALAzS>; Sat, 11 Jan 2003 19:55:18 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:24068
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S268190AbTALAzR>; Sat, 11 Jan 2003 19:55:17 -0500
Subject: Re: System Call Problem
From: Robert Love <rml@tech9.net>
To: "Hall, Luca" <hall@bnl.gov>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <28A2E0D6A920954ABBF13AF712CEBDB6CF0A81@exchange05.bnl.gov>
References: <28A2E0D6A920954ABBF13AF712CEBDB6CF0A81@exchange05.bnl.gov>
Content-Type: text/plain
Organization: 
Message-Id: <1042333450.752.1.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 11 Jan 2003 20:04:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 19:38, Hall, Luca wrote:

> The problem is now that when I boot i see the printk messages
> at the bottom. around 5 - 7 times.

You took the syscall number for getrlimit(2).

You cannot just arbitrarily pick a syscall number, it needs to be a new
and never-before-used number.

Look in include/asm/unistd.h and add your number to the bottom.

	Robert Love

