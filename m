Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267218AbUG1PMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267218AbUG1PMk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267212AbUG1PMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:12:39 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:3471 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S267218AbUG1PLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:11:34 -0400
To: Greg Howard <ghoward@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix system controller communication driver
References: <Pine.SGI.4.58.0407271457240.1364@gallifrey.americas.sgi.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 28 Jul 2004 11:11:17 -0400
In-Reply-To: <Pine.SGI.4.58.0407271457240.1364@gallifrey.americas.sgi.com>
Message-ID: <yq0fz7c9nfu.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg Howard <ghoward@sgi.com> writes:

Greg> Hi Andrew, The following patch
Greg> ("altix-system-controller-driver.patch") implements a driver
Greg> that allows user applications to access the system controllers
Greg> on SGI Altix machines.  It applies on top of the 2.6.8-rc-mm1
Greg> patch.

Greg,

A few quick comments, there might be more, I just spotted these two
points quickly:

1) Please update the struct file_operations assignments to use
   .owner THIS_MODULE, etc. instead of owner:

2) Always check the return values from copy_from_user and copy_to_user
   to avoid userland feeing you bogus pointers.

Jes
