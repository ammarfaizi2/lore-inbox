Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264711AbUDWDcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264711AbUDWDcj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 23:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264714AbUDWDcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 23:32:39 -0400
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:49102 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S264711AbUDWDce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 23:32:34 -0400
From: Paul Misner <paul@misner.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Graphics Mode Woes
Date: Thu, 22 Apr 2004 22:32:28 -0500
User-Agent: KMail/1.6.2
References: <01b801c428cb$737005d0$0900a8c0@bobhitt>
In-Reply-To: <01b801c428cb$737005d0$0900a8c0@bobhitt>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404222232.29150.paul@misner.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 April 2004 07:39 pm, Bobby Hitt wrote:
> Hello,
>
> Here's the related portion of my .config file:
>  #
> # Graphics support
> #
> CONFIG_FB=y
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_IMSTT is not set
> CONFIG_FB_VGA16=y
> CONFIG_FB_VESA=y
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_HGA is not set
> CONFIG_FB_RIVA=y
> # CONFIG_FB_I810 is not set
>
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_PCI_CONSOLE=y
> CONFIG_FONTS=y
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> # CONFIG_FONT_6x11 is not set
> CONFIG_FONT_PEARL_8x8=y
> CONFIG_FONT_ACORN_8x8=y
> # CONFIG_FONT_MINI_4x6 is not set
> # CONFIG_FONT_SUN8x16 is not set
> # CONFIG_FONT_SUN12x22 is not set
>
> #
> # Logo configuration
> #
> CONFIG_LOGO=y
> CONFIG_LOGO_LINUX_MONO=y
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y
>
> Any help or suggestions are appreciated,
>
> Bobby

I believe that you only want a single one of the CONFIG_FB options set.  As I 
recall, having more then one built in to the kernel causes problems, 
especially with VGA16 and VESA.  Why not just turn on CONFIG_FB_VESA=y, and 
make the others modules (=m).

Why not turn off, or at least build as modules, all the things you aren't 
really going to be using.  Building everything into the kernel is a good way 
to cause yourself problems.

As an example, part of my config is:

CONFIG_FB=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y

The only things turned on in the graphics section are displayed above.

Paul
