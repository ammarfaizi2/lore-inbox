Return-Path: <linux-kernel-owner+w=401wt.eu-S1750922AbXACQYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbXACQYN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 11:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbXACQYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 11:24:12 -0500
Received: from pasmtpa.tele.dk ([80.160.77.114]:55237 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbXACQYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 11:24:11 -0500
Date: Wed, 3 Jan 2007 17:24:09 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Pelle Svensson <pelle2004@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Symbol links to only needed and targeted source files
Message-ID: <20070103162409.GA30071@uranus.ravnborg.org>
References: <6bb9c1030701030724k4ca544cfg364e28059cf5dfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bb9c1030701030724k4ca544cfg364e28059cf5dfe@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 04:24:11PM +0100, Pelle Svensson wrote:
> Hi,
> 
> I would like to set up a directory with only links to the source files
> I use during the building of the kernel. The development ide/editor
> will target this directory instead of main source tree. The benefit of this
> is that I don't need to bother about files that are not included
> by the configuration.

Anohter approach would be to use a separate output directory.
In this way you have all generated files in a separate place which
should solve your needs.

To use it do like this:

make mrproper <= To get a clean starting point
mkdir ../o
make O=../o defconfig   <= or some other config target
cd ../o
make

Se also README.

	Sam
