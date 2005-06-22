Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVFVMXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVFVMXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 08:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVFVMXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 08:23:22 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:15233 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261202AbVFVMXJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 08:23:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BY3Nb65hEtJhzgHNfvGFz5DyakfDsRgCdzWXp1/yKqwYNNRfFXYeg9qX1MBzJu/9WVXm/lpy8oBg7/UpfCoHtez14GPMFSSAlFaxyGhKErB1Vr/sZ1ea19gM3wR+cm/yAD/tYfehe/Gv6rfUU0yBVKJP5w92k+5i+eKrPLqDJ0U=
Message-ID: <a4e6962a0506220523791a31da@mail.gmail.com>
Date: Wed, 22 Jun 2005 07:23:06 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Cc: akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org
In-Reply-To: <E1Dl20U-0007Ic-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu>
	 <20050621233914.69a5c85e.akpm@osdl.org>
	 <E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu>
	 <20050622004902.796fa977.akpm@osdl.org>
	 <E1Dl1Ce-0007BO-00@dorka.pomaz.szeredi.hu>
	 <20050622021251.5137179f.akpm@osdl.org>
	 <E1Dl1Oz-0007Dq-00@dorka.pomaz.szeredi.hu>
	 <20050622024423.66d773f3.akpm@osdl.org>
	 <E1Dl20U-0007Ic-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > I'm asking you to expand on what the problems would be if we were to
> > enhance the namespace code as suggested.
> 
> OK, what I was thinking, is that the user could create a new
> namespace, that has all the filesystems remounted 'nosuid'.  This
> wouldn't need any new kernel infrastructure, just a suid-root program
> (e.g. newns_nosuid), that would do a clone(CLONE_NEWNS), then
> recursively remount everything 'nosuid' in the new namespace.  Then
> restore the user's privileges, and exec a shell.
>

I'm confused why everything has to be remounted nosuid.  I understand
enforcing synthetics to be mounted nosuid, but not the rest of the
file systems.  I thought all the problems revolving around the private
namespace solution where the FUSE team's desire to have per-user
namespace and/or per-session namespace versus per-process namespace.

         -eric
