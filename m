Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTE2VXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTE2VXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:23:07 -0400
Received: from a.smtp-out.sonic.net ([208.201.224.38]:23532 "HELO
	a.smtp-out.sonic.net") by vger.kernel.org with SMTP id S262720AbTE2VXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:23:06 -0400
X-envelope-info: <dhinds@sonic.net>
Date: Thu, 29 May 2003 14:36:24 -0700
From: David Hinds <dhinds@sonic.net>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Junfeng Yang <yjf@stanford.edu>
Subject: Re: [CHECKER] pcmcia user-pointer dereference
Message-ID: <20030529143624.A10639@sonic.net>
References: <20030529142238.A8933@sonic.net> <D43209EB-921C-11D7-B8B8-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D43209EB-921C-11D7-B8B8-000A95A0560C@us.ibm.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 04:30:54PM -0500, Hollis Blanchard wrote:
> 
> That's true for pcmcia_get_mem_page. However pcmcia_map_mem_page writes 
> into the structure it verifies. I think pcmcia_get_first/next_window 
> could also be used to corrupt memory (*handle = win in 
> pcmcia_get_window).

The map_mem_page ioctl can only be used by root.  The get_*_window
ioctl's can't corrupt anything because they, like get_mem_page, only
read the target data structures.

-- Dave
