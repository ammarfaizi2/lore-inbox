Return-Path: <linux-kernel-owner+w=401wt.eu-S932135AbXACVOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbXACVOp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbXACVOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:14:45 -0500
Received: from nz-out-0506.google.com ([64.233.162.225]:47520 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932135AbXACVOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:14:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=avaZSzVldZs9xFGi9uyXVHhes2gR/Gm/8KiGBMYVaDBVcjBh9EmKhp7NyHPNtD8OBrlUdt27jcZzmZYnRFKM9zOCtMqDviP1KUlB0hyyAanzz6fdOyZUceYknP1OptamBC8sVN1NPnbUAnMXDvm6Tun/oat+zzpKWXfPnsuzIHc=
Message-ID: <6bb9c1030701031314l1b57bd2brffb61cce68a7174@mail.gmail.com>
Date: Wed, 3 Jan 2007 22:14:43 +0100
From: "Pelle Svensson" <pelle2004@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: Symbol links to only needed and targeted source files
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070103162409.GA30071@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bb9c1030701030724k4ca544cfg364e28059cf5dfe@mail.gmail.com>
	 <20070103162409.GA30071@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

You misunderstand me I think, I already using a separate output directory.
What I like to do is a separate 'source tree' with only valid files
for my configuration. In that way, when I use grep for instance,
I would only hit valid files and not 50 other files which are
not in the current build configuration.

On 1/3/07, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Jan 03, 2007 at 04:24:11PM +0100, Pelle Svensson wrote:
> > Hi,
> >
> > I would like to set up a directory with only links to the source files
> > I use during the building of the kernel. The development ide/editor
> > will target this directory instead of main source tree. The benefit of this
> > is that I don't need to bother about files that are not included
> > by the configuration.
>
> Anohter approach would be to use a separate output directory.
> In this way you have all generated files in a separate place which
> should solve your needs.
>
> To use it do like this:
>
> make mrproper <= To get a clean starting point
> mkdir ../o
> make O=../o defconfig   <= or some other config target
> cd ../o
> make
>
> Se also README.
>
>         Sam
>
