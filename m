Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270453AbTHSOAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270869AbTHSNjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 09:39:54 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:34293 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S270447AbTHSNcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 09:32:16 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Date: Tue, 19 Aug 2003 08:27:05 -0500
X-Mailer: KMail [version 1.2]
References: <3F3EB8FA.1080605@sktc.net> <MDEHLPKNGKAHNMBLJOLKEEBAFDAA.davids@webmaster.com> <bhs2sb$3fd$1@cesium.transmeta.com>
In-Reply-To: <bhs2sb$3fd$1@cesium.transmeta.com>
MIME-Version: 1.0
Message-Id: <03081908270500.01226@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 August 2003 21:43, H. Peter Anvin wrote:
> Followup to:  <MDEHLPKNGKAHNMBLJOLKEEBAFDAA.davids@webmaster.com>
> By author:    "David Schwartz" <davids@webmaster.com>
> In newsgroup: linux.dev.kernel
>
> > 	There is no mechanism that is guaranteed to terminate a process other
> > than sending yourself an exception that is not caught. So in cases where
> > you must guarantee that your process terminates, it is perfectly
> > reasonable to send yourself a SIGILL.
>
> exit(2)?
>
> 	-hpa

Nope... A monitoring process must send the exit to a different thread... which
may be being directed to generate a core dump.
