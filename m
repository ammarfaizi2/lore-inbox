Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269197AbRHNDSd>; Mon, 13 Aug 2001 23:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270018AbRHNDSX>; Mon, 13 Aug 2001 23:18:23 -0400
Received: from rj.sgi.com ([204.94.215.100]:2746 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S269197AbRHNDSF>;
	Mon, 13 Aug 2001 23:18:05 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: paragw@excite.com
cc: Colonel <klink@clouddancer.com>, linux-kernel@vger.kernel.org
Subject: Re: 
In-Reply-To: Your message of "Mon, 13 Aug 2001 20:08:01 MST."
             <27661815.997758482137.JavaMail.imail@scorch.excite.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Aug 2001 13:17:51 +1000
Message-ID: <22627.997759071@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001 20:08:01 -0700 (PDT), 
Parag Warudkar <paragw@excite.com> wrote:
>Additionally include/linux/modules/ksyms.ver 
>requires following  two lines to be added for modules to work
>
>#define __ver_no_llseek 8d4d42a6 
>#define no_llseek       _set_ver(no_llseek)

Don't do that.  If you have module symbol versions turned on
(CONFIG_MODVERSIONS) then after any change that affects exported
symbols, you must make mrproper and rebuild from scratch.  See
http://www.tux.org/lkml/#s8-8.

