Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbULaAIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbULaAIM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 19:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbULaAIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 19:08:12 -0500
Received: from mproxy.gmail.com ([216.239.56.243]:58225 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261789AbULaAIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 19:08:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Qayn/U3bDvOxQ7oqXzG67EiNAQoz+dpmJqKGqcbLu+kCVndJFnqlm9UWorheq/mMbcC1zQ11iLsR8hmG64UFdL0nFQrQTKPxyM6U21fzZPdsFXx3A7ERB4PPaFxA90qeCZCyfbzvC1L3J9qz/ZfK11LT3tgu6NoN78pOwOdVoRo=
Message-ID: <21d7e997041230160823e222a8@mail.gmail.com>
Date: Fri, 31 Dec 2004 11:08:06 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [bk pull] drm core/personality split
Cc: Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <9e4733910412300918750b47e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0412300733380.25314@skynet>
	 <21d7e997041229234860454564@mail.gmail.com>
	 <9e4733910412300918750b47e8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this include the changes to get rid of intermodule too?

Yes the code also directly calls into the AGP backend if AGP is
enabled on the machine,

I'm not sure this is the perfect solution but all the other ways of
doing things via inter_module and module_get are objected to by
Christoph so I'm happy to do it this way as it simple, some embedded
folks might give out but turning off AGP in the config turns it off
for the DRM as well...

Dave.
