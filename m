Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbUJWOfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbUJWOfy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbUJWOfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:35:52 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:11227 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261200AbUJWOfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:35:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mbfDHx0jpt8xxRaIP9OBa1FS6t7lQ69uTZx7/Apwfzf582dpaRrrtDC++ie4EIDpBfV7704EsisuPimvt+ZRakFNwC8zNieXYatz8L34ll/0Wmaf0ZXJ3gHtKLK0NoXW8qnWmI7GNAU1awNmU7bLtj3b9wkc3leSEGoZ73fD8PE=
Message-ID: <9e473391041023073578b11eb6@mail.gmail.com>
Date: Sat, 23 Oct 2004 10:35:41 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
In-Reply-To: <20041023095644.GC30137@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e473391041022214570eab48a@mail.gmail.com>
	 <20041023095644.GC30137@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I deal with something like a Redhat kernel where CONFIG_AGP is
set but the kernel may be running on hardware without AGP present. In
this case the AGP modules will not be loaded but DRM will still have
symbol references to the AGP symbols. You have to have some kind of
weak symbol reference in this case.

-- 
Jon Smirl
jonsmirl@gmail.com
