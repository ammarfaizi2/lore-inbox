Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbWBYItH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbWBYItH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 03:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbWBYItH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 03:49:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63146 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932618AbWBYItG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 03:49:06 -0500
Subject: Re: Looking for a file monitor
From: Arjan van de Ven <arjan@infradead.org>
To: Hareesh Nagarajan <hnagar2@gmail.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Diego Calleja <diegocg@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43FFD684.2020309@gmail.com>
References: <200602241949_MC3-1-B93F-2159@compuserve.com>
	 <43FFD684.2020309@gmail.com>
Content-Type: text/plain
Date: Sat, 25 Feb 2006 09:49:02 +0100
Message-Id: <1140857342.2991.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-24 at 22:01 -0600, Hareesh Nagarajan wrote:
> Chuck Ebbert wrote:
> > In-Reply-To: <43FF3C1C.5040200@gmail.com>
> > 
> > On Fri, 24 Feb 2006 at 11:02:20 -0600, Hareesh Nagarajan wrote:
> > 
> >> But if we want to keep a track of all the files that are opened, read, 
> >> written or deleted (much like filemon; ``Filemon's timestamping feature 
> >> will show you precisely when every open, read, write or delete, happens, 
> >> and its status column tells you the outcome."), we can write a simple 
> >> patch that makes a note of these events on the VFS layer, and then we 
> >> could export this information to userspace, via relayfs. It wouldn't be 
> >> too hard to code a relatively efficient implementation.
> > 
> >  Doesn't auditing do all this?
> 
> I have no idea about auditing, but I would guess it internally uses inotify.


it doesn't; it uses the audit framework which, by the way, exactly does
what the proposed patch above would do :)


