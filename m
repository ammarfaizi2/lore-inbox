Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVFPXaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVFPXaE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 19:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVFPXaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 19:30:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5848 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261637AbVFPX37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 19:29:59 -0400
Date: Thu, 16 Jun 2005 16:29:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: why does fsync() on a tmpfs directory give EINVAL?
Message-Id: <20050616162933.25dee57b.akpm@osdl.org>
In-Reply-To: <42B20317.6000204@nortel.com>
References: <42B1DBF1.4020904@nortel.com>
	<20050616135708.4876c379.akpm@osdl.org>
	<42B20317.6000204@nortel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortel.com> wrote:
>
> Andrew Morton wrote:
> > Chris Friesen <cfriesen@nortel.com> wrote:
> 
> >> Would a patch that makes it 
> >>just return successfully without doing anything be accepted?
> > 
> > 
> > yup.
> 
> Currently tmpfs reuses the simple_dir_operations from libfs.c.
> 
> Would it make sense to add the empty fsync() function there, and have 
> all other users pick it up as well?  Is this likely to break stuff?

Isn't simple_sync_file() suitable?

