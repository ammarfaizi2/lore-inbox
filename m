Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWDIVrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWDIVrU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 17:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWDIVrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 17:47:20 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:39852 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750897AbWDIVrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 17:47:19 -0400
Date: Sun, 9 Apr 2006 23:47:18 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/19] kconfig: fix typo in change count initialization
In-Reply-To: <20060409212704.GB30208@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0604092346100.32445@scrub.home>
References: <Pine.LNX.4.64.0604091727190.23120@scrub.home>
 <20060409212704.GB30208@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Apr 2006, Sam Ravnborg wrote:

> > @@ -325,7 +325,7 @@ int conf_read(const char *name)
> >  				sym->flags |= e->right.sym->flags & SYMBOL_NEW;
> >  	}
> >  
> > -	sym_change_count = conf_warnings && conf_unsaved;
> > +	sym_change_count = conf_warnings || conf_unsaved;
> >  
> >  	return 0;
> >  }
> 
> Please explain what this actually fixes.

Configuration needs saving when either of these conditions is true.

bye, Roman
