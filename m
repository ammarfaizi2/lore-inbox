Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751889AbWAEDP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbWAEDP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWAEDP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:15:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33227 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751889AbWAEDP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:15:28 -0500
Date: Wed, 4 Jan 2006 22:15:17 -0500
From: Dave Jones <davej@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/15] Ubuntu patch sync
Message-ID: <20060105031517.GD2658@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org
References: <0ISL003P992UCY@a34-mta01.direcway.com> <20060104140627.1e89c185@dxpl.pdx.osdl.net> <1136412768.4430.28.camel@grayson> <20060104143023.5b2f7967@dxpl.pdx.osdl.net> <1136414740.4430.44.camel@grayson> <20060104150658.5b3f0d20@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104150658.5b3f0d20@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 03:06:58PM -0800, Stephen Hemminger wrote:

 > > Not defending any of these reasons. I'd love to not have all this work
 > > of pulling in and tracking the drivers that our users need/want, but
 > > it's going to be a lot of work. Maybe I'll start emailing them about
 > > getting their code in the kernel tree.
 > 
 > I don't mean to play shoot the messenger, you are helping a lot by doing this
 > I wish every distro did.

FWIW, Red Hat has been under constant pressure from users asking us
to merge driver x 'because $otherdistro has it' for a long time.

The first reason we say no 99.9% of the time is because to stay in
a position where we can quickly rebase to a new upstream release, you 
have to be light enough to not have to spend a day rediffing/fixing
add-on patches.

The second reason (and this is actually more important than the first,
but as I'm a selfish sod, I thought of my own wellbeing first), is that
historically there have been some vendors who have taken the position
"Our driver is in Red Hat's distro, we don't care about anyone else".
For obvious reasons, this isn't a good thing, and something we now
go out of our way to discourage.

>From time to time, we do carry drivers that aren't upstream yet.
ipw2x00 got a good beating in RHEL4 & FC3 before it made it into Linus' tree.
A lot of issues were found in that driver early on by rhel beta-testers,
which Intel went and fixed, long before it was proposed for upstream inclusion.
Whilst some of those issues would probably have been found by -mm exposure
eventually, living in a distro tree gets it a lot more exposure.

Getting 'previews' of drivers into the grubby hands of end-users
who are prepared for a bumpy ride, and are prepared to give feedback
to improve things is invaluable.

For Fedora at least, I don't object to the notion of carrying a handful
of continually improving drivers which are making progress at upstream
inclusion.  What I don't want to entertain is the idea of grabbing
random drivers and dumping them in the distro tree just because their
upstream has no motivation at getting them merged in Linus' tree.
(Which is sadly a category quite a few of the requests that we get
 fall into)

		Dave

