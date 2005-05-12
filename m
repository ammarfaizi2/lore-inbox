Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVELQQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVELQQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 12:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVELQQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 12:16:45 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:40750 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262070AbVELQQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 12:16:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cyhepEehshXF31744o4xqdGhulXt3dz7OgIypn2Gu2JRUAK5YdLuu7QDodI9gRLU1NsXDB81og5vq4X1Zn1V06UnCT5CQXAIMAFiBrxancdIdjOTOREB2X24MmbO2D6KLue/aSXdGUFe8RuWh58PMP10UTgPaxeyTb+B+K+FB08=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kobject_register failed for intelfb (-EACCES) (Re: 2.6.12-rc4-mm1)
Date: Thu, 12 May 2005 20:20:29 +0400
User-Agent: KMail/1.7.2
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, airlied@linux.ie,
       davej@codemonkey.org.uk, linux-fbdev-devel@lists.sourceforge.net
References: <20050512033100.017958f6.akpm@osdl.org> <20050512154335.GD21765@kroah.com> <20050512085933.03dc0d10.akpm@osdl.org>
In-Reply-To: <20050512085933.03dc0d10.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505122020.29290.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 May 2005 19:59, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >  On Thu, May 12, 2005 at 04:58:01PM +0400, Alexey Dobriyan wrote:
> >  > kobject Intel(R) 830M/845G/852GM/855GM/865G/915G Framebuffer Driver:
> >  > registering. parent: <NULL>, set: drivers
> >  > kobject_register failed for Intel(R) 830M/845G/852GM/855GM/865G/915G
> > 
> >  Someone tried to put a "/" in a kobject name, which is not allowed.
> >  Actually the name seems to be set to:
> >  	"Intel(R) 830M/845G/852GM/855GM/865G/915G Framebuffer Driver"
> >  which is a bit verbous if you want to create a directory name :)

> Seems like a fix such as this will be needed:

> -	.name =		"Intel(R) " SUPPORTED_CHIPSETS " Framebuffer Driver",
> +	.name =		"intelfb",

It works.
