Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWFTFZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWFTFZS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWFTFZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:25:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65483 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964939AbWFTFZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:25:15 -0400
Date: Mon, 19 Jun 2006 22:25:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [-mm patch] binfmt_elf: fix checks for bad address
Message-Id: <20060619222512.58ba3e48.akpm@osdl.org>
In-Reply-To: <200606200059_MC3-1-C2E8-8C45@compuserve.com>
References: <200606200059_MC3-1-C2E8-8C45@compuserve.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 00:55:24 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> -#define BAD_ADDR(x) ((unsigned long)(x) > TASK_SIZE)
> +#define BAD_ADDR(x) ((unsigned long)(x) >= TASK_SIZE)

Convince us that this is correct for all the other users of BAD_ADDR() in
this file.

