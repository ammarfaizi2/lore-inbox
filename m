Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVAGW4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVAGW4k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVAGWzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:55:47 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:13829 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261686AbVAGWzb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:55:31 -0500
Date: Fri, 7 Jan 2005 23:56:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-os@analogic.com
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 167] Kill unused variables in the net code
Message-ID: <20050107225631.GA21884@mars.ravnborg.org>
Mail-Followup-To: linux-os@analogic.com,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org
References: <200501072111.j07LB4EN011223@anakin.of.borg> <Pine.LNX.4.61.0501071636160.21727@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501071636160.21727@chaos.analogic.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 04:38:36PM -0500, linux-os wrote:
> >-#define read_unlock(lock)	do { } while(0)
> >+#define read_unlock(lock)	(void)(lock) /* Not "unused variable". */
> 
> But don't all you need to do is:
> 
> #define read_unlock(x)

Then tbl will still be unused - and compiler will emit warning.

	Sam
