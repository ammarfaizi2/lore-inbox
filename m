Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUKVC4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUKVC4k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 21:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUKVC4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 21:56:39 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:53644 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261904AbUKVCzm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 21:55:42 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>,
       Antonino Daplas <adaplas@pol.net>
Subject: Re: [Linux-fbdev-devel] Re: [2.6 patch] drivers/video/: misc cleanups
Date: Mon, 22 Nov 2004 10:55:06 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
References: <20041121153702.GB2829@stusta.de> <20041121155811.GA2961@stusta.de>
In-Reply-To: <20041121155811.GA2961@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411221055.07693.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 November 2004 23:58, Adrian Bunk wrote:
> On Sun, Nov 21, 2004 at 04:37:02PM +0100, Adrian Bunk wrote:
> > The patch below does the following cleanups under drivers/video/ :
> > - make some needlessly global code static
> > - the following was needlessly EXPORT_SYMBOL'ed:
> >   - fbcon.c: fb_con
> >   - mdacon.c: fb_blank
> >   - fbmon.c: get_EDID_from_firmware (completely unused)
> >...
>
> I forgot one thing:
>
> Please review my global_mode_option removal in modedb.c .
>
> It was always NULL and I'd say the only usage was wrong (although it
> had no practical effect).

Should be ok to remove it.  I only see fb_find_mode using it, and as
you've concluded, usage is not very clear.

BTW: The global_mode_option, previously, is filled up when no driver is
specified in the boot options, such as "video=1024x768@60".  But this was
removed during the fb initialization cleanup.

Tony


