Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbVKPXrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbVKPXrU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030566AbVKPXrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:47:20 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:9668 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1030565AbVKPXrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:47:19 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Nick Warne <nick@linicks.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 make - path name breakage (perhaps) 
In-reply-to: Your message of "Wed, 16 Nov 2005 15:09:04 -0000."
             <200511161509.04855.nick@linicks.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Nov 2005 10:47:06 +1100
Message-ID: <22029.1132184826@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2005 15:09:04 +0000, 
Nick Warne <nick@linicks.net> wrote:
>The reason is due to the untarred path name that includes () I found.
>
>I tested on virgin kernel 2.4.31 with GNU Make version 3.79.1.
>
>top level directory of kernel source as a test:
>
>linux-2.4.31(test)/
>
>And the errors (with a lot removed) - it does a little first then:
>
>> make mrproper
>/bin/sh: -c: line 1: syntax error near unexpected token 
>`/home/nick/kernel/linux-2.4.31(t'

Rename the directory to linux-2.4.31-test.  The kernel build code
assumes that there are no shell special characters in file names.

