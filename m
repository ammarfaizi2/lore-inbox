Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVCaSwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVCaSwJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 13:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVCaSwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 13:52:08 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:62326 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261616AbVCaSv5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 13:51:57 -0500
Date: Thu, 31 Mar 2005 20:52:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: ioe-lkml@axxeo.de, matthew@wil.cx, lkml <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: [RFC/PATCH] network configs: disconnect network options from drivers
Message-ID: <20050331185226.GA8146@mars.ravnborg.org>
References: <20050330234709.1868eee5.randy.dunlap@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050330234709.1868eee5.randy.dunlap@verizon.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 11:47:09PM -0800, Randy.Dunlap wrote:
> 
> - some Networking options need to be qualified with CONFIG_NET
You can something along the lines os:

menu "Networking options and protocols"
  
config NET
	bool "Networking support"
	default y

if NET

...

menu "Network device support"
...
endmenu

...

endif
endmenu

Then everything wrapped in between if NET/endif is dependent on NET
without stating this explicitly.
You will alos have the menu nice indented.

	Sam
