Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbVJZOqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbVJZOqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 10:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVJZOqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 10:46:08 -0400
Received: from smtp12.wanadoo.fr ([193.252.22.20]:19217 "EHLO
	smtp12.wanadoo.fr") by vger.kernel.org with ESMTP id S932622AbVJZOqH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 10:46:07 -0400
X-ME-UUID: 20051026144605862.D29211C000CC@mwinf1202.wanadoo.fr
Subject: Re: Race between "mount" uevent and /proc/mounts?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Sergey Vlasov <vsu@altlinux.ru>,
       Roderich.Schupp.extern@mch.siemens.de, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20051026143417.GA18949@vrfy.org>
References: <0AD07C7729CA42458B22AFA9C72E7011C8EF@mhha22kc.mchh.siemens.de>
	 <20051025140041.GO7992@ftp.linux.org.uk>
	 <20051026142710.1c3fa2da.vsu@altlinux.ru>
	 <20051026111506.GQ7992@ftp.linux.org.uk>  <20051026143417.GA18949@vrfy.org>
Content-Type: text/plain
Message-Id: <1130337932.3340.1.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Wed, 26 Oct 2005 16:45:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 16:34, Kay Sievers wrote:

> They are actually events for claim/release of a block device. As uevents
> are bound to kobjects we needed to send these events from an existing device
> which is the blockdev itself.
> 
> Sure, the event itself, has nothing to do with a filesystem. The names are
> like this for historical reasons and "CLAIM/RELEASE" may be less confusing.
> The events are used as a trigger to rescan /proc/mounts instead of polling
> it constantly.
> 
> If you have a better idea where to plug it, or if we better rename it, we
> should do that...

Make /proc/mount send an inotify event ?


