Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbSJHSIS>; Tue, 8 Oct 2002 14:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261320AbSJHSIR>; Tue, 8 Oct 2002 14:08:17 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:33037
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261313AbSJHSIE>; Tue, 8 Oct 2002 14:08:04 -0400
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
From: Robert Love <rml@tech9.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021008104244.GA1895@werewolf.able.es>
References: <1034044736.29463.318.camel@phantasy> 
	<20021008104244.GA1895@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Oct 2002 14:08:44 -0400
Message-Id: <1034100524.746.1364.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-08 at 06:42, J.A. Magallon wrote:

> Sorry if this is a newbie question, but, does glibc pass flags blindly
> to the syscal ?? Ie, I do not need to rebuild glibc to use this in
> open(), fcntl() and so on, just I can make sure that bit 04000000
> is set in the flags.

Right.  Do something like:

	#define O_STREAMING 04000000

	fd = open(file, ... | O_STREAMING);

or open it via fopen() and use fcntl() to set O_STREAMING.

	Robert Love


