Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbUBJBEA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 20:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265619AbUBJBEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 20:04:00 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:39941 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S265615AbUBJBD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 20:03:58 -0500
Date: Tue, 10 Feb 2004 01:35:50 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andreas Fester <Andreas.Fester@gmx.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [2.6 PATCH] persist qconf options
In-Reply-To: <4028075E.1070809@gmx.de>
Message-ID: <Pine.LNX.4.58.0402100050230.7851@serv>
References: <4028075E.1070809@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 9 Feb 2004, Andreas Fester wrote:

> @@ -1145,6 +1162,10 @@
>   	menuList->updateListAll();
>   }
>
> +bool ConfigMainWindow::getShowAll() {
> +	return configList->showAll;
> +}
> +
>   void ConfigMainWindow::setShowDebug(bool b)
>   {
>   	if (showDebug == b)

All these access functions are really not neccessary.
If we change this I'd like to see this done properly. First all the
settings business should be moved into a small helper class, so that there
are not x number of new arguments to the ConfigList constructor. The
saving of the settings should be connected to aboutToQuit().
Bonus points if you also save the list mode and the position of the
splitter. :)

bye, Roman
