Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965464AbWKNMal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965464AbWKNMal (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 07:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965468AbWKNMal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 07:30:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:44861 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965464AbWKNMak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 07:30:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SfMndEwRdtStowqF2N5YlK2lYTu9c8U8o0GiZWmIV5GbrGkQiI1jskXptbvouNaWSn8VmZzff9bI15Br/4tT+kMCKDhGy7v8lBCfhcyH2C5dI0SM7lwgGE+ZKUI8/1FBLcQSsTzJeSrUBiTjWdJGP/CymvSh8SupvVQPrOuy8Ic=
Message-ID: <41840b750611140430k3b46023dr9a01b8b38bbb535d@mail.gmail.com>
Date: Tue, 14 Nov 2006 14:30:38 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Suleiman Souhlal" <ssouhlal@freebsd.org>
Subject: Re: [PATCH 0/2] Make the TSC safe to be used by gettimeofday().
Cc: "Andi Kleen" <ak@suse.de>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       "Jiri Bohac" <jbohac@suse.cz>,
       "Nigel Cunningham" <ncunningham@cyclades.com>,
       "Pavel Machek" <pavel@suse.cz>
In-Reply-To: <45592497.1080109@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <455916A5.2030402@FreeBSD.org> <200611140250.57160.ak@suse.de>
	 <45592497.1080109@FreeBSD.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/06, Suleiman Souhlal <ssouhlal@freebsd.org> wrote:
> I believe that the results returned will always be monotonic, as long as
> the frequency of the TSC does not change from under us (that is, without
> the kernel knowing). This is because we "synchronize" each CPU's vxtime
> with a global time source (HPET) every time we know the TSC rate changes.

Does this hold after a suspend/resume cycle? You could be resuming
with a different CPU clock than what you suspended with, and I'm not
sure anything guarantees an early enough re-sync.

  Shem
