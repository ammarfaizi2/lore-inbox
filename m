Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUEDVRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUEDVRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 17:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUEDVQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 17:16:07 -0400
Received: from mail.kroah.org ([65.200.24.183]:48089 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264623AbUEDVP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 17:15:56 -0400
Date: Tue, 4 May 2004 13:37:38 -0700
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Ian Morgan <imorgan@webcon.ca>, helpdeskie@bencastricum.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 Sensors & USB problems
Message-ID: <20040504203738.GJ24802@kroah.com>
References: <1081349796.407416a4c3739@imp.gcu.info> <Pine.LNX.4.58.0404171756400.11374@dark.webcon.ca> <Pine.LNX.4.58.0404171944160.11425@dark.webcon.ca> <20040418075140.6c118202.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040418075140.6c118202.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 07:51:40AM +0200, Jean Delvare wrote:
> > Can anyone explain, however, why my i2c bus showed up as number 0
> > under linux <= 2.6.4, and now always as number 1 under linux 2.6.5?
> > The is no number 0 any more.
> 
> The bus number allocation scheme is such that once a number has been
> used once (since the machine last booted) it will not be used again.
> This is admittedly not ideal and should be fixed. I suspect that the fix
> isn't trivial because the current structures would make the new scheme
> have a poor algorithmic complexity (O(2) maybe), but I haven't checked
> yet. Greg, can you confirm?

It's not due to the complexity, it's just due to the fact that I haven't
gotten around to doing it yet :)

Patches to fix this are gladly welcome if the current situation really
bothers people.  No userspace tools should have a problem with the way
things are right now.  If they do have problems, please let me know.

thanks,

greg k-h
