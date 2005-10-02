Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbVJBDTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVJBDTY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 23:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVJBDTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 23:19:24 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:3292 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750949AbVJBDTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 23:19:23 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: A possible idea for Linux: Save running programs to disk
To: lokum spand <lokumsspand@hotmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 02 Oct 2005 05:19:10 +0200
References: <4SXfo-7hM-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1ELuNb-0001HV-OQ@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lokum spand <lokumsspand@hotmail.com> wrote:

> I allow myself to suggest the following, although not sure if I post in
> the right group:
> 
> Suppose Linux could save the total state of a program to disk, for
> instance, imagine a program like mozilla with many open windows. I give
> it a SIGNAL-SAVETODISK and the process memory image is dropped to a
> file. I can then turn off the computer and later continue using the
> program where I left it, by loading it back into memory.

What about the open file descriptors? If the program uses temporary files,
closing them will destroy the data in the temp files. Therefore you can't
close these fds, and this prevents you from doing a shutdown.
Use suspend-to-disk instead.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
