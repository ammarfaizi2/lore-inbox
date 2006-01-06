Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWAFSs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWAFSs6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWAFSs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:48:57 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:7948 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932438AbWAFSs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:48:57 -0500
Date: Fri, 6 Jan 2006 19:48:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 2/7]  enable unit-at-a-time optimisations for gcc4
Message-ID: <20060106184841.GA13917@mars.ravnborg.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136543914.2940.11.camel@laptopd505.fenrus.org> <43BEA672.4010309@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BEA672.4010309@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 12:18:42PM -0500, Jeff Garzik wrote:
> 
> ACK, with a note:  gcc also supports limited program-at-a-time -- you 
> pass multiple .c files on the same command line, and specify a single 
> output on the command line.
> 
> It would be nice to update kbuild to do this for single directory 
> modules....

How much will it gain?
It takes some kbuild hacking I think.

Also why should we care so much for multi directory modules?
They can be adopted as needed if we introduce it.
xfs and aic7xxx springs to my mind.

I do not recall we have modules that uses .o files created from another
kbuild file - which is the only situation that matters here.

	Sam
