Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270479AbTGSCqM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 22:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270480AbTGSCqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 22:46:12 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:21478 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S270479AbTGSCpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 22:45:39 -0400
Date: Fri, 18 Jul 2003 20:39:24 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: RAMON_GARCIA_F <RAMON_GARCIA_F@terra.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suggestion for a new system call: convert file handle to a cookie for transfering file handles between processes.
Message-ID: <20030718203924.N639@nightmaster.csn.tu-chemnitz.de>
References: <fb7ddfab3b.fab3bfb7dd@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <fb7ddfab3b.fab3bfb7dd@teleline.es>; from RAMON_GARCIA_F@terra.es on Thu, Jul 17, 2003 at 07:47:11PM +0200
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19dhxb-0005ZT-00*naujCMj.RIc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ramon,

On Thu, Jul 17, 2003 at 07:47:11PM +0200, RAMON_GARCIA_F wrote:
> Let cdwritter be a program for writting CDs. Unlike other programs,
> cdwritter is rationally designed. It is a server process that listens
> through a named pipe, thus making it easy to write either command line
> or graphical interfaces that use its functionality. The named pipe
> is called /var/run/cdwritter
 
Calling this tool simply with an argument (eg. CD to write) and
accepting commands from stdin, outputting status info on stdout
and errors on stderr is even simpler and requires no API changes ;-)

> An alternative would be that cdwritter accepts a file name instead of
> a cookie. But then, the author of cdwritter would have to check if the
> user has permission to access the file. This makes cdwritter more error
> prone.
 
With my suggested change this is done implicitly.

But with that cookie suggestion in place, to remove the ability
for fds to be reference countable, since the user can build
circular dependencies now, which he for now can just do with
AF_UNIX sockets.

Regards

Ingo Oeser
