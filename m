Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWGMSPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWGMSPT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWGMSPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:15:19 -0400
Received: from mx.pathscale.com ([64.160.42.68]:21894 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030265AbWGMSPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:15:18 -0400
Date: Thu, 13 Jul 2006 11:15:17 -0700 (PDT)
From: Dave Olson <olson@pathscale.com>
Reply-To: olson@pathscale.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, discuss@x86-64.org
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
In-Reply-To: <m1d5c94jx8.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0607131109540.3583@topaz.pathscale.com>
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
 <m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com> <p734pxnojyt.fsf@verdi.suse.de>
 <m1wtajed4d.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.61.0607112307130.10551@osa.unixfolk.com>
 <m1psgbcnv9.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0607122048230.4819@topaz.pathscale.com>
 <m1d5c94jx8.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006, Eric W. Biederman wrote:
| And I tested it on one of them.  The problem is that there is no API in
| the kernel for properly handling hypertransport interrupts or even faking
| it well currently.  There is no shame in breaking a bad unmaintainable
| hack, as I did.  The responsible thing is to when you find one to
| fix up the code so that things work by design in a maintainable way,
| which I am attempting to do.

There's no problem providing a better replacement, just make sure
that the existing drivers can use it.

| All existing drivers that use HT interrupts are broken by design.

That's a statement designed to provoke arguments, and I'll just leave
it that we disagree.

| Sure.  In that case can I please have a good description of what
| weird hacks your hardware designers have done.

There's really nothing special at all about the interrupt
setup, except in one very minor way.   The value of the HT interrupt
destination address needs to be copied from HT config space, to
an internal chip register (which is, can, and should be, handled by
the driver init code).

| As I understand
| it I cannot write to the standard registers HT capability registers
| and have things work correctly.

There is nothing unusual or special about that part at all.  The only
unusual item is that mentioned in the paragraph above.

| The functions I exported I intend to export.  The complaint seems to
| be that you don't have anything that will work on earlier kernels.
| I have to agree you don't.

Huh?  I didn't say anything that could possibly be read as applying
to earlier kernels, and to be crystal clear, that's not my concern
at all.

Maybe somebody else can articulate what I'm trying to say, but I don't
think I can say it in a clearer way.

Dave Olson
dave.olson@qlogic.com
