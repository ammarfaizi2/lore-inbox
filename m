Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUIKOt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUIKOt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 10:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268159AbUIKOt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 10:49:56 -0400
Received: from trantor.org.uk ([213.146.130.142]:53917 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S267976AbUIKOtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 10:49:55 -0400
Subject: Re: [PATCH 2.6 NETFILTER] new netfilter module ipt_program.c
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Patrick McHardy <kaber@trash.net>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
In-Reply-To: <4142F4CC.7080708@trash.net>
References: <20040911124106.GD24787@lkcl.net>  <4142F4CC.7080708@trash.net>
Content-Type: text/plain
Date: Sat, 11 Sep 2004 15:49:35 +0100
Message-Id: <1094914175.8495.66.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-11 at 14:51 +0200, Patrick McHardy wrote:
> Luke Kenneth Casson Leighton wrote:
> > decided to put this into a separate module.  based on ipt_owner.c.
> > does full program's pathname.  like ipt_owner, only suitable for
> > outgoing connections.
> 
> I agree that it would be useful to match the full path, but
> the patch is broken, as are the owner match's pid-, sid- and
> command-matching options. You can't grab files->file_lock
> outside of process context. Besides, we want to consolidate
> functionality, not add new matches that do basically the same
> as existing ones.

This is a binary compatibility issue, I don't think it's possible to add
Lukes functionality to ipt_owner without breaking iptables
compatibility.

-- 
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

