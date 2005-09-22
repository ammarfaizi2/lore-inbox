Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965235AbVIVGDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbVIVGDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 02:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbVIVGDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 02:03:54 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:15027 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965234AbVIVGDx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 02:03:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KhlpUD/vBSLa/wbRnlYpoAd1jOwSAFX0VFhUshJ9e7zV1tmUfBCu8bJeXXvD0YBF1rBCfD1uxzojzrNJaG6oh50CSG0/0EwuVOgzIOFR/19hVnIH9IWvsi6JJ/8J36SJKCNjZCF5O8vlev21Bpgcby3DVbwXut8++7NUNQaw16A=
Message-ID: <c295378405092123032534d93b@mail.gmail.com>
Date: Wed, 21 Sep 2005 23:03:53 -0700
From: "Jason R. Martin" <nsxfreddy@gmail.com>
Reply-To: "Jason R. Martin" <nsxfreddy@gmail.com>
To: Florin Malita <fmalita@gmail.com>
Subject: Re: [PATCH] channel bonding: add support for device-indexed parameters
Cc: akpm@osdl.org, davem@davemloft.net, ctindel@users.sourceforge.net,
       fubar@us.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       bonding-devel@lists.sourceforge.net
In-Reply-To: <20050922000444.369c32c2.fmalita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050922000444.369c32c2.fmalita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/05, Florin Malita <fmalita@gmail.com> wrote:
> While originally I was interested in being able to set a different
> primary interface for each bond device (same primary for all bond
> devices doesn't make any sense), most parameters deserve the same
> treatement.
>
> This patch adds support for device indexed module parameter
> arrays instead of the old plain scalars. Mostly module_param
> substitutions and parameter parsing logic tweaking.
[snip]

Personally I think working to get the sysfs support finished in
bonding and stop relying on module parameters to configure bonds would
be better, since bonds will truly be independent of each other and be
able to be added and removed on the fly.  Having worked with a
previous attempt to set per-bond values through module parameters
(http://marc.theaimsgroup.com/?t=110558187800001&r=1&w=2), it's easy
to get pretty crazy.  For example, you can have more than one
arp_ip_target, and they really should be per bond as well, so how do
you divvy those up via module parameters?

Jason
