Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUDGIaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 04:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUDGIaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 04:30:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:58803 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261426AbUDGIay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 04:30:54 -0400
Subject: Re: RFC: COW for hugepages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>
In-Reply-To: <20040407005353.45323dcd.akpm@osdl.org>
References: <20040407074239.GG18264@zax>
	 <20040407005353.45323dcd.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1081326594.1382.54.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Apr 2004 18:29:54 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 17:53, Andrew Morton wrote:
> David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> > Doing the COW for hugepages turns out not to be terribly difficult.
> >  Is there any reason not to apply this patch?
> 
> Not much, except that it adds stuff to the kernel.
> 
> Does anyone actually have a real-world need for the feature?

Yup, porting some apps to use hugepages, when those apps
rely on fork & cow semantics typically. Also, implicit use of
hugepages (usually via a malloc override library).

Ben.


