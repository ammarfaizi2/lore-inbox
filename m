Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVAERKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVAERKy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVAERKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:10:54 -0500
Received: from dialin-145-254-057-142.arcor-ip.net ([145.254.57.142]:56837
	"EHLO spit.home") by vger.kernel.org with ESMTP id S261839AbVAERKu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:10:50 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kconfig: avoid temporary file
Date: Wed, 5 Jan 2005 13:40:31 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20041230235146.GA9450@mars.ravnborg.org> <200501030155.05203.zippel@linux-m68k.org> <20050103051002.GB8113@mars.ravnborg.org>
In-Reply-To: <20050103051002.GB8113@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501051340.31794.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 03 January 2005 06:10, Sam Ravnborg wrote:

> Next step is to integrate Petr Baudis patch to link lxdialog with mconf.

I had two major problems with his patch:
- it didn't resize when the terminal changed.
- window layering, old windows are not removed and just drawn over (this was 
especially a problem with help texts).

The current approach solves this rather nicely by just reinitialising 
everything.
