Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265223AbUFHPGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbUFHPGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 11:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUFHPGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 11:06:06 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:25217 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S265214AbUFHPGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 11:06:03 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Zoltan.Menyhart@bull.net
Subject: Re: Who owns those locks ?
Date: Tue, 8 Jun 2004 09:05:52 -0600
User-Agent: KMail/1.6.2
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <40A1F4BE.4A298352@nospam.org> <200406070906.54132.bjorn.helgaas@hp.com> <40C572C8.20B13640@nospam.org>
In-Reply-To: <40C572C8.20B13640@nospam.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406080905.52673.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 June 2004 2:03 am, Zoltan Menyhart wrote:
> - You keep my code, it is correct for a memory size up to 16 Tbytes.

Many if not most large machines have sparse address spaces,
so you may have memory at an address that will cause a
problem even if the actual amount of memory is much smaller.

The main point is that I wouldn't want a time bomb that
will silently fail when somebody happens to boot on such
a machine.  Whether that's avoided by a "miraculous" bit,
throwing away problem pages at boot-time, avoiding task
allocation at specific addresses, etc.,  is secondary.
