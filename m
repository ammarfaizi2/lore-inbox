Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbVLIRDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVLIRDF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbVLIRDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:03:05 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:56523 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932524AbVLIRDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:03:04 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH][mm] swsusp: limit image size
Date: Fri, 9 Dec 2005 18:04:21 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200512072246.06222.rjw@sisk.pl> <4399A737.40809@suse.de>
In-Reply-To: <4399A737.40809@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512091804.22397.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 9 December 2005 16:48, Stefan Seyfried wrote:
> Rafael J. Wysocki wrote:
> 
> > The following patch limits the size of the suspend image to approx. 500 MB,
> > which should improve the overall performance of swsusp on systems with
> > more than 1 GB of RAM.
> > 
> > It introduces the constant IMAGE_SIZE that can be set to the preferred size
> > of the image (in MB) and modifies the memory-shrinking part of
> > swsusp to take this constant into account (500 is the default value
> > of IMAGE_SIZE).
> 
> What happens if IMAGE_SIZE is bigger than free swap? Do we "try harder"
> or do we fail?

First, with swsusp the image can't be bigger than 1/2 of lowmem (1/2 of RAM
on x86-64) and the too great values of IMAGE_SIZE have no effect.  Still, if
the amount of free swap is smaller than 1/2 of RAM and the image happens
to be bigger, we will fail.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
