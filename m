Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbTLORK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTLORK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:10:28 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:12456 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263803AbTLORKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:10:23 -0500
Date: Mon, 15 Dec 2003 18:08:43 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215170843.GA10857@louise.pinerecords.com>
References: <Pine.LNX.4.44.0312150917170.32061-100000@coffee.psychology.mcmaster.ca> <3FDDD8C6.3080804@intel.com> <3FDDDC68.80209@backtobasicsmgmt.com> <3FDDE39E.1050300@intel.com> <Pine.LNX.4.53.0312151150090.10342@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0312151150090.10342@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-15 2003, Mon, 11:55 -0500
Richard B. Johnson <root@chaos.analogic.com> wrote:

> Easy way to remember is that if you have either a static or a global
> variable that is initialized, it will be in the .data segment and,
> therefore take up space in the executable. If it is not initialized,
> it will be in the .bss segment, automatically zeroed by the loader.
> In this case, the executable contains length information, not the data.
> Local variables are never initialized unless there's an '=' in the
> code.

I think you guys are all missing Vladimir's point, which is that gcc
is able to detect that an explicit initialization of a static variable
happens to be to the value of ZERO, and place the variable in .bss
_in spite of the initialization_.

-- 
Tomas Szepe <szepe@pinerecords.com>
