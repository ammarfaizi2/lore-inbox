Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266347AbUA2UhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 15:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266348AbUA2UhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 15:37:17 -0500
Received: from scrat.hensema.net ([62.212.82.150]:34275 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S266347AbUA2UhM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 15:37:12 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: Lindent fixed to match reality
Date: Thu, 29 Jan 2004 20:37:07 +0000 (UTC)
Message-ID: <slrnc1irnj.2is.erik@bender.home.hensema.net>
References: <20040129193727.GJ21888@waste.org>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall (mpm@selenic.com) wrote:
> I've been fiddling with cleaning up some old code here and suggest the
> following to make Lindent match actual practice more closely. This does:
> 
> a) (no -psl)
> 
> void *foo(void) {
> 
>  instead of
> 
> void *
> foo(void) {

You just nicely broke 'find . -name *.c | xargs grep ^foo'.

Why make functions harder to find? It's just one line... Being
able to navigate the source tree with standard unix utils is a
Good Thing.

Even better, IMHO:

void *
foo(void)
{
}

Yes, that takes a full three lines. But within the function body
you can just reverse search for ^{ and you're at the function
declaration. Not nearly as useful as grepping for a function
name, but still a nice thing to have, IMHO.

> 
> b) (no -bs) "sizeof(foo)" rather than "sizeof (foo)"

Agreed.

> c) (-ncs) "(void *)foo" rather than "(void *) foo"

Agreed.


-- 
Erik Hensema <erik@hensema.net>
