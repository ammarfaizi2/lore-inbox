Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272277AbTGYTtg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272278AbTGYTtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:49:36 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:16912
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S272277AbTGYTtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:49:35 -0400
Date: Fri, 25 Jul 2003 13:04:40 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cutting down on boot messages
Message-ID: <20030725200440.GA1686@matchmail.com>
Mail-Followup-To: Jurriaan <thunder7@xs4all.nl>,
	linux-kernel@vger.kernel.org
References: <20030725195752.GA8107@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725195752.GA8107@middle.of.nowhere>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 09:57:52PM +0200, Jurriaan wrote:
> of messages? I'm now at 22k of dmesg, including raid, usb, apic etc, for
> a single CPU system.

And you want more static buffers to store that in than now?  Many people
won't like that.

You'd do better to have a boot time command line option to limit printk
messages to err, or above.  Most of the printk messages have been given a
severity already, so this shouldn't be a problem, and it will probably
uncover some errors in the severity of certain messages.

Anyway, there are other ways to peel this union, including having the
messages to to tty2 instead of console (I've seen patches for this posted
before).
