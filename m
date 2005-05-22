Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVEVThf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVEVThf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 15:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVEVThf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 15:37:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9188 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261339AbVEVTha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 15:37:30 -0400
Date: Sun, 22 May 2005 21:37:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Reiner Sailer <sailer@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@mail.wirex.com,
       kylene@us.ibm.com, emilyr@us.ibm.com, toml@us.ibm.com
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and Readme
Message-ID: <20050522193717.GB3685@elf.ucw.cz>
References: <1116596180.8156.8.camel@secureip.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116596180.8156.8.camel@secureip.watson.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +Limitations: IMA does not detect corruption of software once it is
> +loaded into main memory. Instead, it indicates known vulnerabilities
> +in such software (e.g., buffer overflow) by securely identifying the
> +software at load-time. Only executable files (binaries, libraries,
> +kernel modules) are measured by default. However, IMA offers a
> +sysfs-interface that allows applications to instruct the kernel to
> +measure files that they have opened.

What is it good for, then? So I have to put my backdoor into script,
not into an executable...

> +Some of our work shows that IMA is very useful to detect Rootkit
> +exploits that totally take over the software of a Linux system but
> +cannot hide themselves from contributing to the TPM aggregate and this
> +will be detectable from a non-corrupted platform. While the corrupted
> +system might not show the Rootkit, a remote party can securely
> +identify known bad or unknown software having been loaded into the
> +system.

How does it work? It is corrupted software, not your TPM chip that is
talking over network.... Do you sign the measurements inside TPM chip?

								Pavel
