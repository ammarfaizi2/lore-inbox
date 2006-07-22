Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWGVQ6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWGVQ6X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWGVQ6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:58:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:52690 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750939AbWGVQ6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:58:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tF5jrcZ+eS5OmZ0RcyKNf8Zchyx9MVPbUMwedN/fqIIMrwJiJSY4HHbXjcNL143mSZ2GX9shhlCq9661gzJ2/yC3nK01RErs3VH2aG506wSRh5XFfs6K0K0x047zCzH6Rm/F6iUEu/N1kKMIxTnhGIHS9yAJGiVizhS2BcBQeZQ=
Message-ID: <806dafc20607220958n1f5d0c88s6e64d1771585ea69@mail.gmail.com>
Date: Sat, 22 Jul 2006 12:58:21 -0400
From: "Christopher Montgomery" <xiphmont@gmail.com>
To: "Ian Stirling" <tandra@mauve.plus.com>
Subject: Re: [linux-usb-devel] USB bandwidth enforcement troubles.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44C212A8.7050806@mauve.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44C212A8.7050806@mauve.plus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing is simple in USB, although 1.1 is alot easier than 2.0 :-)

The logs, unfortunately, don't tell much.  But the short answer is
probably 'don't use USB bandwidth enforcement'.  If the bandwidth
request it is reporting is accurate, the kernel is correctly rejecting
the request.  But, I suspect strongly either the kernel is
miscalculating or the headset is vastly overreporting its needs.
991us in a FS frame would indeed be too much to schedule, but no
headset would ever have cause to use that kind of bandwidth.

Monty
