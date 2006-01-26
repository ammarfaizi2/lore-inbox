Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWAZWa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWAZWa2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWAZWa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:30:27 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:25257 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964934AbWAZWa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:30:27 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43D94D06.8090708@s5r6.in-berlin.de>
Date: Thu, 26 Jan 2006 23:28:22 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux1394-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee1394: allow building with absolute SUBDIRS path
References: <1138234743.10202.3.camel@localhost>
In-Reply-To: <1138234743.10202.3.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.176) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg wrote:
> This patch allows building the modules with an absolute SUBDIRS path,
> especially for building them out of tree.
> 
> Signed-Off-By: Johannes Berg <johannes@sipsolutions.net>
> 
> --- a/drivers/ieee1394/Makefile
> +++ b/drivers/ieee1394/Makefile
> @@ -18,7 +19,7 @@ obj-$(CONFIG_IEEE1394_AMDTP) += amdtp.o
>  obj-$(CONFIG_IEEE1394_CMP) += cmp.o
>  
>  quiet_cmd_oui2c = OUI2C   $@
> -      cmd_oui2c = $(CONFIG_SHELL) $(srctree)/$(src)/oui2c.sh < $< > $@
> +      cmd_oui2c = $(CONFIG_SHELL) $(src)/oui2c.sh < $< > $@
>  
>  targets := oui.c
>  $(obj)/oui.o: $(obj)/oui.c
> 

Looks good, although you should rediff against current sources
and post at linux1394-devel. :-)

If you want to develop on top of latest 1394 sources but with a
released kernel underneath, you could check out my quilt trees.
http://me.in-berlin.de/~s5r6/linux1394/updates/
-- 
Stefan Richter
-=====-=-==- ---= ==-=-
http://arcgraph.de/sr/
