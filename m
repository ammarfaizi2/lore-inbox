Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263577AbUDURwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbUDURwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 13:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbUDURwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 13:52:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61577 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263577AbUDURwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 13:52:12 -0400
Message-ID: <4086B4B7.4080008@pobox.com>
Date: Wed, 21 Apr 2004 13:51:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Hopkins <sah@coraid.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: AoE inclusion into 2.4.x
References: <c6be8c22d61f39eeb861c900d5abd7fe@borf.com>
In-Reply-To: <c6be8c22d61f39eeb861c900d5abd7fe@borf.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Hopkins wrote:
> Greetings,
> 
> I would like to offer our driver for inclusion into the 2.4 kernel.
> Marcelo suggested (strongly) that I make this request officially
> to the list.
> 
> The driver code is available from:
> 
> 	http://www.coraid.com/support/aoe-1.6.tar
> 
> I'm now going to cheat and copy our prior correspondence.  Please CC me
> on any comments / questions as I'm not a lkml subscriber.

Overall it seems reasonably clean, though the following combination 
seems a bit silly:

         if(access_ok(VERIFY_WRITE, arg, sizeof(long)))
         if(!copy_to_user((long *) arg, &d->disk.ssize, sizeof (long)))


