Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTKQUdl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 15:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbTKQUdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 15:33:41 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:20747 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261384AbTKQUdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 15:33:39 -0500
Date: Mon, 17 Nov 2003 21:33:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: HOWTO build modules in 2.6.0 ...
Message-ID: <20031117203336.GA1714@mars.ravnborg.org>
Mail-Followup-To: Wojciech 'Sas' Cieciwa <cieciwa@alpha.zarz.agh.edu.pl>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58L.0311171939150.25906@alpha.zarz.agh.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0311171939150.25906@alpha.zarz.agh.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 08:00:50PM +0100, Wojciech 'Sas' Cieciwa wrote:
> 
> Hi,
> 
> How can I build kernel modele from other package without root, or copying 
> all from /usr/scr/linux/ ??
> When I try build kernel module from user i got error,
> 
> [...]
> make[1]: Leaving directory `/users/cieciwa/rpm/BUILD/eagle-1.0.4/driver'
> /usr/bin/make -C /usr/src/linux SUBDIRS=`pwd` modules;
> make[1]: Entering directory `/usr/src/linux-2.6.0'
>   HOSTCC  scripts/fixdep
> cc1: Permission denied: opening dependency file scripts/.fixdep.d

Hi Sas.
What you really need is the possibility to specify an alternate location
for output files.

Use the following:
make -C /usr/src/linux SUBDIRS=`pwd` O=/users/cieciwa/rpm/BUILD/eagle-1.0.4/linux modules

O=/users/cieciwa/rpm/BUILD/eagle-1.0.4/linux
tell kbuild to locate all files in the specified directory, which must exist.
This is also the location of .config, so make sure to copy that one over.

	Sam
