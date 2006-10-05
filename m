Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWJEOpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWJEOpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWJEOpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:45:33 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:11531 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932106AbWJEOpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:45:32 -0400
Date: Thu, 5 Oct 2006 10:44:50 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Alex Owen <r.alex.owen@gmail.com>
Cc: linux-kernel@vger.kernel.org, c-d.hailfinger.kernel.2004@gmx.net,
       aabdulla@nvidia.com
Subject: Re: forcedeth net driver: reverse mac address after pxe boot
Message-ID: <20061005144442.GB18408@tuxdriver.com>
References: <55c223960610040919u221deffei5a5b6c37cfc8eb5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c223960610040919u221deffei5a5b6c37cfc8eb5a@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 05:19:20PM +0100, Alex Owen wrote:

> The obvious fix for this is to try and read the MAC address from the
> canonical location... ie where is the source of the address writen
> into the controlers registers at power on? But do we know where that
> may be?

This seems like The Right Thing (TM) to me, but we need someone from
NVidia(?) to provide that information.  Ayaz?

> The other solution would be unconditionally reset the controler to
> it's power on state then use the current logic? can we reset the
> controller via software?

This seems like a plausible alternative.

The MAC address validation schemes suggested by others would probably
"work", but they would be a bit fragile.  For example, every new vendor
of forcedeth hardware would have a new OUI to be added to the list.

John
-- 
John W. Linville
linville@tuxdriver.com
