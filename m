Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbVLHWlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbVLHWlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbVLHWlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:41:22 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:3015 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932684AbVLHWlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:41:21 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Date: Thu, 8 Dec 2005 23:42:38 +0100
User-Agent: KMail/1.9
Cc: Andy Isaacson <adi@hexapodia.org>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051205081935.GI22168@hexapodia.org> <200512071217.41814.rjw@sisk.pl> <20051207113003.GD2563@elf.ucw.cz>
In-Reply-To: <20051207113003.GD2563@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512082342.38759.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 7 December 2005 12:30, Pavel Machek wrote:
}-- snip --{
> > Let me explain what I have in mind.
> > 
> > For starters, please observe that the addresses we use are page-aligned,
> > so the least significant bit is always zero.  Thus it can be used as a marker.
> > 
> > Now before we save the image we can mark blank pages by setting
> > the least significant bit of .orig_address to 1 in the coresponding PBEs.
> > We save the "marked" .orig_address values to the image.
> 
> Well, nice optimalization, but how many pages are actually full of
> zeros?

According to the results I have obtained, there are about 1000 such
pages in the image on my box, for total image sizes between 28000
and 80000 pages (ie above 28000 of pages in the image the number
of blank pages is almost constant).

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
