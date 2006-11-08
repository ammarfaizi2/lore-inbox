Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161730AbWKHWUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161730AbWKHWUv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161744AbWKHWUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:20:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:49998 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161730AbWKHWUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:20:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Z/nbuh6ds2L3OYxxBEJCjR/c3Djg+gehRUaoL6DSTZm348akIWnoowWrEDBfRhQ66Y8uZxR0lPOW6WiO5N71bDr/qdbisFPMZAYbqoM24eNHE455u9OR9daPZvvndj15fQ/0BcMFd0lkjHRbp6btHjEG4z1BpZNLDl9jr2bnlZI=
Date: Thu, 9 Nov 2006 01:20:46 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dave Jones <davej@redhat.com>, Randy Dunlap <randy.dunlap@oracle.com>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gx-suspmod: fix "&& 0xff" typo
Message-ID: <20061108222046.GE4972@martell.zuzino.mipt.ru>
References: <20061108220435.GA4972@martell.zuzino.mipt.ru> <20061108141007.e0adf333.randy.dunlap@oracle.com> <20061108221626.GH3309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108221626.GH3309@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > > -	params->pci_rev = class_rev && 0xff;
>  > > +	params->pci_rev = class_rev & 0xff;
>  >
>  > Hi,
>  > any kind of automated detection on that one?
>
> grep -r "&& 0x" .  seems to be pretty effective modulo
> some false-positives.

Obligatory nit-picking:

	grep '&&[ 	]*0[xX][fF]' -r .

