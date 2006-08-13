Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWHME7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWHME7P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 00:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWHME7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 00:59:14 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:42798 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1030229AbWHME7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 00:59:14 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@suse.de>
cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: module compiler version check still needed? 
In-reply-to: Your message of "Sun, 13 Aug 2006 06:48:36 +0200."
             <200608130648.36178.ak@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 Aug 2006 14:59:19 +1000
Message-ID: <31645.1155445159@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen (on Sun, 13 Aug 2006 06:48:36 +0200) wrote:
>
>Does anybody know of any reason why we would still need the compiler version
>check during module loading? AFAIK on i386 it was only needed to handle
>2.95 (which got dropped) and on x86-64 it was never needed. Is there
>a need on any other architecture for it?

IA64 still needs the check.  include/asm-ia64/spinlock.h generates
different calls to the out of line spinlock handler, depending on the
version of gcc.

