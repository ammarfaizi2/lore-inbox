Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUAOPGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 10:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUAOPGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 10:06:44 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:40208 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263607AbUAOPGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 10:06:43 -0500
Date: Thu, 15 Jan 2004 16:05:59 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>
cc: linux-kernel@vger.kernel.org
Subject: Re: True story: "gconfig" removed root folder...
In-Reply-To: <1074177405.3131.10.camel@oebilgen>
Message-ID: <Pine.LNX.4.58.0401151558590.27223@serv>
References: <1074177405.3131.10.camel@oebilgen>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Jan 2004, Ozan Eren Bilgen wrote:

> Today I downloaded 2.6.1 kernel and tried to configure it with "make
> gconfig". After all changes I selected "Save As" and clicked "/root"
> folder to save in. Then I clicked "OK", without giving a file name. I
> expected that it opens root folder and lists contents. But this magic
> configurator removed (rm -Rf) my root folder and created a file named
> "root". It was a terrible experience!..

I only did a quick check with menuconfig. Are you sure it's really
removed? It should still be there as "/root.old".
I probably should change the behaviour of the save routine to behave
differently for directories as argument, but it doesn't remove it.
(Changing gconfig to only accept files in the save request would probably
be nice too...)

bye, Roman
