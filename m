Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRBYGLV>; Sun, 25 Feb 2001 01:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129885AbRBYGLM>; Sun, 25 Feb 2001 01:11:12 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:41726 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129881AbRBYGKy>;
	Sun, 25 Feb 2001 01:10:54 -0500
Date: Sun, 25 Feb 2001 01:10:48 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: John R Lenton <john@grulic.org.ar>
cc: Peter Samuelson <peter@cadcamlab.org>, Wakko Warner <wakko@animx.eu.org>,
        linux-kernel@vger.kernel.org
Subject: Re: OK to mount multiple FS in one dir?
In-Reply-To: <20010207035959.A2223@grulic.org.ar>
Message-ID: <Pine.GSO.4.21.0102250108480.24871-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Feb 2001, John R Lenton wrote:

> On Wed, Feb 07, 2001 at 12:25:10AM -0600, Peter Samuelson wrote:
> > 
> > [Wakko Warner]
> > > I have a question, why was this idea even considered?
> > 
> > Al Viro likes Plan9 process-local namespaces.  He seems to be trying to
> > move Linux in that direction.  In the past year he has been hacking the
> > semantics of filesystems and mounting, probably with namespaces as an
> > eventual goal, and this is one of the things that has fallen out of the
> > implementation.
> 
> Aren't "translucid" mounts the idea behind this?

Nope. Completely different beast - bindings have nothing to layered
filesystems. I.e. if we bind /foo to /bar then /foo/barf and /bar/barf
are the same object. Translucent-type would have one of them redirecting
all requests to another.

