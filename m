Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266717AbUG1BEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266717AbUG1BEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 21:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266744AbUG1BEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 21:04:32 -0400
Received: from hera.kernel.org ([63.209.29.2]:54928 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266717AbUG1BEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 21:04:31 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: tty1 and italian charset ...
Date: Wed, 28 Jul 2004 01:03:10 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ce6u0e$c3t$1@terminus.zytor.com>
References: <200407261647.40006.AlberT@SuperAlberT.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1090976590 12414 127.0.0.1 (28 Jul 2004 01:03:10 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 28 Jul 2004 01:03:10 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200407261647.40006.AlberT@SuperAlberT.it>
By author:    "Emiliano 'AlberT' Gabrielli" <AlberT@SuperAlberT.it>
In newsgroup: linux.dev.kernel
> 
> I already used "loadkeys it" and it seems to success, but tty1 still doesn't 
> prints "òàèìù" characters.
> 

Sounds like you're trying to print Latin-1 on an UTF-8 console or vice versa.

	echo -ne '\\033%G'	-- Enable UTF-8
	echo -ne '\\033%@'	-- Disable UTF-8

	-hpa
