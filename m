Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWDTKGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWDTKGe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWDTKGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:06:33 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:54917 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750810AbWDTKGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:06:33 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [linux-pm] Re: [RFC][PATCH -mm] swsusp: use less memory during resume
Date: Thu, 20 Apr 2006 12:05:41 +0200
User-Agent: KMail/1.9.1
Cc: linux-pm@lists.osdl.org, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200604181319.47400.rjw@sisk.pl> <200604191005.41701.rjw@sisk.pl> <200604191831.45936.ncunningham@cyclades.com>
In-Reply-To: <200604191831.45936.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604201205.42421.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 19 April 2006 10:31, Nigel Cunningham wrote:
> On Wednesday 19 April 2006 18:05, Rafael J. Wysocki wrote:
> > On Tuesday 18 April 2006 15:07, Nigel Cunningham wrote:
> > > On Tuesday 18 April 2006 21:19, Rafael J. Wysocki wrote:
}-- snip --{ 
> > > Haven't looked at the patch itself, but this sounds like a great idea. I
> > > wonder though, won't the 50% limit still apply, because you'll still have
> > > to make an atomic copy to start with (unless you figure out which pages
> > > aren't going to change and therefore don't need to be atomically copied)?
> >
> > You are right, and I'm going to figure out which pages won't change.  I
> > think I have some good candidates. ;-)
> 
> LRU by any chance? :)

Generally yes, but not all of them.  First of all pages that are mapped by
frozen processes.  Maybe some others too, but that will have to be handled
with care. ;-)

Greetings,
Rafael
