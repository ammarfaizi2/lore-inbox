Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVAUQtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVAUQtk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVAUQtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:49:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:30082 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261523AbVAUQrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:47:31 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH][RFC]: Clean up resource allocation in i8042 driver
Date: Fri, 21 Jan 2005 08:47:04 -0800
User-Agent: KMail/1.7.1
Cc: dtor_core@ameritech.net, Prarit Bhargava <prarit@sgi.com>,
       linux-kernel@vger.kernel.org
References: <41F11C66.5000707@sgi.com> <d120d500050121074313788f99@mail.gmail.com> <20050121163540.GC4795@ucw.cz>
In-Reply-To: <20050121163540.GC4795@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501210847.04654.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 21, 2005 8:35 am, Vojtech Pavlik wrote:
> No. But vacant ports usually return 0xff. The problem here is that 0xff
> is a valid value for the status register, too. Fortunately this patch
> checks for 0xff only after the timeout failed.

On PCs you'll get all 1s, but on some ia64 platforms and others, you'll take a 
hard machine check exception if you try to access non-existent memory (mmio, 
port space, or otherwise).

Jesse
