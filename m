Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288557AbSBMSpp>; Wed, 13 Feb 2002 13:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288566AbSBMSp1>; Wed, 13 Feb 2002 13:45:27 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:9611 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288557AbSBMSpQ>;
	Wed, 13 Feb 2002 13:45:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: root@chaos.analogic.com, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: How to check the kernel compile options ?
Date: Wed, 13 Feb 2002 19:35:58 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020213132419.20719A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020213132419.20719A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16b4G6-0002Oi-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2002 07:27 pm, Richard B. Johnson wrote:
> On Wed, 13 Feb 2002, Randy.Dunlap wrote:
> 
> > On Wed, 13 Feb 2002, Richard B. Johnson wrote:
> > 
> > | On Wed, 13 Feb 2002, Horst von Brand wrote:
> > |
> > | > Daniel Phillips <phillips@bonn-fries.net> said:
> > | > > On February 12, 2002 05:38 pm, Bill Davidsen wrote:
> > | >
> > | > [...]
> > | [SNIPPED...]
> > |
> > | My idea is to take the .config file and remove most of its
> > | redundancy and unnecessary verbage. Then, the result is
> > | compressed and written to a constant global array, linked
> > | into the kernel. Both the array and the array length will then
> > | be available from /proc/kcore for user-mode tools to recreate the
> > | .config file.
> > 
> > This is a bit similar to what I did last weekend (and attach
> > here).  Mine goes into the kernel boot file, however, so that
> > it can be read even when the kernel isn't running.
> > 
> > I'll experiment with ideas from Andreas (thanks) or Ian Soboroff
> > to create a userspace get-config tool.
> > 
> > One small nit:  you say "user-mode tools", but /proc/kcore
> > is read-only for root only -- right?
> > That's not desirable or required IMO.
> 
> Hmmm. You are going to make a kernel and don't have root-access to
> create a kernel configuration file?

Reducing the number of operations that have to be performed as root
is Good[tm].

-- 
Daniel
