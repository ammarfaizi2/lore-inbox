Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292332AbSCABDz>; Thu, 28 Feb 2002 20:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310286AbSCABAD>; Thu, 28 Feb 2002 20:00:03 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:17418 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S310267AbSCAA5E>; Thu, 28 Feb 2002 19:57:04 -0500
Date: Fri, 1 Mar 2002 01:53:23 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Alexander Sandler <ASandler@store-age.com>
Cc: Allo! Allo! <lachinois@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel module ethics.
Message-ID: <20020301005323.GC7956@arthur.ubicom.tudelft.nl>
In-Reply-To: <DCC3761A6EC31643A3BAF8BB584B26CC0DB959@exchange.store-age.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCC3761A6EC31643A3BAF8BB584B26CC0DB959@exchange.store-age.com>
User-Agent: Mutt/1.3.27i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 02:05:36PM +0200, Alexander Sandler wrote:
> My company developing some comercial product and one sunny day smart
> guys from our company decided to make Linux to support it.
> I am the guy who had to do it. And I had almost exactly the same
> problems as you have.
> What I did was following. First, we do not distribute sources. We
> distribute binary only. It was quite a problem because of version
> information on modules symbols. So, we asked from our clients to
> disable it when using our driver. As a result loading precompiled
> driver became possible. Currently I have to maintain two versions of
> the driver (UP and MP), but things can't be too perfect.

Nothing special so far, UP and SMP binaries for every kernel out there.
Oh, and of course you need to provide the about seven versions
specifically optimised for a certain type of CPU, so that makes
fourteen binaries per kernel version. It's only a small amount of work,
right?

> Another sunny day, one of our clients asked for a driver for Linux
> running on quad IA64 machine. Since we don't have such machine here,
> we had to give this client the sources, but before doing this, I
> scrambled the sources so it become completely impossible to read them
> and to modify them. The scrabler I used called cmunge. It was quite
> hard to use it for a driver since it's built for userland apps. but
> it is possible and I did managed to scramble the sources. And if you
> are afraid that it doesn't do it's job well anough, Well... trust me.
> It does!

  http://www.vcpc.univie.ac.at/~jhm/cmunge/

And you're serious you trust *that*? Give me a day and I'll get
readable source back: start with indent, load source in an editor, and
use search and replace to get decent identifiers back. OK, it's not the
original source, but it can certainly be used to improve the driver.
You really underestimate the inventiveness of other people.

> This two ideas may help you with your problems as they did with mine.

Your first idea only showed that you already have quite a lot of work
for each kernel version, and that it will only become worse with each
architecture you add to your pool of supported systems. I think you
nicely pointed out why having binary-only drivers is a bad idea from a
maintainability perspective.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
