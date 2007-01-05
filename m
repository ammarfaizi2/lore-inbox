Return-Path: <linux-kernel-owner+w=401wt.eu-S1161060AbXAEMAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbXAEMAt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 07:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbXAEMAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 07:00:49 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:22072 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161060AbXAEMAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 07:00:48 -0500
Message-ID: <459E3DE8.9050100@tls.msk.ru>
Date: Fri, 05 Jan 2007 15:00:40 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Pelle Svensson <pelle2004@gmail.com>
CC: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: Symbol links to only needed and targeted source files
References: <6bb9c1030701030724k4ca544cfg364e28059cf5dfe@mail.gmail.com>	 <20070103162409.GA30071@uranus.ravnborg.org> <6bb9c1030701031314l1b57bd2brffb61cce68a7174@mail.gmail.com>
In-Reply-To: <6bb9c1030701031314l1b57bd2brffb61cce68a7174@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pelle Svensson wrote:
> Hi Sam,
> 
> You misunderstand me I think, I already using a separate output directory.
> What I like to do is a separate 'source tree' with only valid files
> for my configuration. In that way, when I use grep for instance,
> I would only hit valid files and not 50 other files which are
> not in the current build configuration.

So take a look at those generated files - there are .dep files in there,
which lists dependencies of every file which has been compiled for your
configuration.   Take them, build a list of filenames, and (sym)link them
into separate dir.  Some small awk/sed/grep/sort/uniq/xargs/ln magic and
you're done... ;)

/mjt
