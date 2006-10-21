Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161185AbWJUAhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbWJUAhu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWJUAhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:37:50 -0400
Received: from twin.jikos.cz ([213.151.79.26]:57041 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1030366AbWJUAht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:37:49 -0400
Date: Sat, 21 Oct 2006 02:37:40 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2
In-Reply-To: <20061021022438.46e5904f@werewolf-wl>
Message-ID: <Pine.LNX.4.64.0610210233530.29022@twin.jikos.cz>
References: <20061020015641.b4ed72e5.akpm@osdl.org> <20061021022438.46e5904f@werewolf-wl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1747641777-1357376291-1161391060=:29022"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1747641777-1357376291-1161391060=:29022
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 21 Oct 2006, J.A. Magall=F3n wrote:

> Stupid question: how can I build sunrpc as a module ? I have digged=20
> through menuconfig and gconfig and am not able to set SUNRPC=3Dm, it just=
=20
> gets autoselected y/n by other options.

CONFIG_SUNRPC is set to the value to which you set CONFIG_NFS_FS - look at=
=20
option NFS_FS in fs/Kconfig:

config NFS_FS
        tristate "NFS file system support"
        depends on INET
        select LOCKD
        select SUNRPC
        select NFS_ACL_SUPPORT if NFS_V3_ACL

So if you want sunrpc to be built as module, set CONFIG_NFS_FS "NFS=20
filesystem support" to M. It just works(tm).

--=20
Jiri Kosina
---1747641777-1357376291-1161391060=:29022--
