Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUBIU43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 15:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUBIU43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 15:56:29 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:9735 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265152AbUBIUz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 15:55:59 -0500
Date: Mon, 9 Feb 2004 21:55:57 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Ari Pollak <ajp@aripollak.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD-ROM problems in at least 2.6.2-rc1-mm2 and above
Message-ID: <20040209215557.A1134@pclin040.win.tue.nl>
References: <c08rem$86a$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <c08rem$86a$1@sea.gmane.org>; from ajp@aripollak.com on Mon, Feb 09, 2004 at 03:44:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 03:44:03PM -0500, Ari Pollak wrote:

> The attached program for manually locking the CD-ROM tray used to work 
> in 2.6.0 and 2.6.1, and possibly some earlier versions of 2.6.2 when 
> called like "cd-lock /dev/hdc", where hdc is my CD-ROM drive. However, 
> under 2.6.2-rc1-mm2 and 2.6.2-mm1, calling the program with an empty 
> drive (which used to work) results in the following:
> 
> open failed: No medium found

> open("/dev/cdrom", O_RDONLY)            = -1 ENOMEDIUM (No medium found)

Things will work better with
	open("/dev/cdrom", O_RDONLY | O_NONBLOCK);
