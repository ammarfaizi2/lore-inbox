Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUGZGTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUGZGTm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 02:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUGZGTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 02:19:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:21475 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264919AbUGZGTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 02:19:39 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Limit number of concurrent hotplug processes
Date: Mon, 26 Jul 2004 08:19:36 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Hannes Reinecke <hare@suse.de>,
       linux-hotplug-devel@lists.sourceforge.net
References: <40FD23A8.6090409@suse.de> <20040725182006.6c6a36df.akpm@osdl.org>
In-Reply-To: <20040725182006.6c6a36df.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407260819.36739.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Hannes Reinecke <hare@suse.de> wrote:
> > the attached patch limits the number of concurrent hotplug processes.

> hm, it's a bit sad that this happens.  Are you able to tell us more about
> what is causing such an explosion of module probes?

I dont know exactly which scenario Hannes has seen, but its quite simple to 
trigger this scenario with almost any s390/zSeries.

Using the Hardware Management Console or z/VM you are able to hotplug 
(deactive/activate/attach/detach) almost every channel path. As a channel 
path can connect a big bunch of devices lots of machine checks are 
triggered, which causes lots of hotplugs. The same amount of machine checks 
could happen if a hardware failure happens. 

Some month ago I played around with a diet version of  hotplug. This program 
was fast and small enough to make my scenario work properly. Nevertheless, 
as hannes already stated this will only delay the problem. 

cheers

Christian

