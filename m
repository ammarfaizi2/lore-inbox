Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWATSYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWATSYL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 13:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWATSYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 13:24:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22706 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751137AbWATSYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 13:24:10 -0500
Subject: Re: [PATCH]-jsm driver fix for linux-2.6.16-rc1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "V. Ananda Krishnan" <mansarov@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, akpm@osdl.org,
       gregkh@suse.de
In-Reply-To: <43D1099E.3050509@us.ibm.com>
References: <43D1099E.3050509@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Jan 2006 18:23:19 +0000
Message-Id: <1137781399.24161.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-01-20 at 10:02 -0600, V. Ananda Krishnan wrote:
> Hi,
> 
>    The following patch takes into account the dynamically allocated 
> tty_buf changes and hence fixes the jsm driver.  Please let me have the 
> feed-back.

- Do you still need the shortcut stuff with your own private buffer ?

I'd like to move to a model where ldiscs free up the tty buffers to both
improve the locking and kill the horrible DONT_FLIP hacks in n_tty. If
you do it isn't a problem but I need to ensure there is a way to
directly allocate a buffer for this use.

Alan

