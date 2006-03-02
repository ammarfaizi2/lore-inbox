Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752034AbWCBSwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbWCBSwp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbWCBSwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:52:44 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:8737 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752034AbWCBSwn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:52:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B9/cm5VB6/c/hPge3VrXtsWA8sRm1RhPvhlcFWvLrkTNP29eOW1sLOVXHDkkCKgX/51ysfSh3mShL+lZ4/eu/454f+f+PzYfGweB9g2VJPpwLm4i2pAPPMgxecmavzRBisBP8Qs+wdy7U/a0spm8RAJmdAGSiazVS7uMxflfMy8=
Message-ID: <7c3341450603021052l39773247q@mail.gmail.com>
Date: Thu, 2 Mar 2006 18:52:21 +0000
From: "Nick Warne" <nick@linicks.net>
Reply-To: "Nick Warne" <nick@linicks.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Compenstating for clock drift
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910603020759m10545cd1va3ef67398f1f38ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910603020759m10545cd1va3ef67398f1f38ea@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> From my logs I can see that my system clock is consistently drifting
> about 3 seconds every 24hrs and ntp is faithfully correcting it.  Can
> the kernel track long term data like this and insert/remove a few
> extra ticks to minimize the size of the ntp drift corrections?

ntp should do that anyway - check you have a drift file defined in ntp.conf

# Drift file.  Put this in a directory which the daemon can write to.
# No symbolic links allowed, either, since the daemon updates the file
# by creating a temporary in the same directory and then rename()'ing
# it to the file.
#
driftfile /etc/ntp/drift

Over time it will adjust to suit and step the changes gracefully.

Nick
