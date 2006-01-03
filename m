Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWACKrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWACKrT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 05:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWACKrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 05:47:19 -0500
Received: from cat.linpro.no ([80.232.36.160]:42701 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751332AbWACKrS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 05:47:18 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Avoid namespace pollution in <asm/param.h>
References: <200601021702.k02H2mLh015729@hera.kernel.org>
	<20060102181355.GA16324@mars.ravnborg.org>
From: des@linpro.no (Dag-Erling =?iso-8859-1?q?Sm=F8rgrav?=)
Date: Tue, 03 Jan 2006 11:47:17 +0100
In-Reply-To: <20060102181355.GA16324@mars.ravnborg.org> (Sam Ravnborg's
 message of "Mon, 2 Jan 2006 19:13:55 +0100")
Message-ID: <ujrhd8ly4ei.fsf@cat.linpro.no>
User-Agent: Gnus/5.090024 (Oort Gnus v0.24) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:
> config.h is always implicit included using -include option to gcc,
> so the #include <linux/config.h> is redundant and the correct patch
> would be to get rid of it.

In that case, you have your work cut out for you:

des@xps ~/src/linux-2.6.14.5% grep -r linux/config.h . | wc -l
    3777

This is likely to have a significant impact on compilation time...

DES
-- 
Dag-Erling Smørgrav - des@linpro.no
