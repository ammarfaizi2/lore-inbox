Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbTI1Rvf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 13:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbTI1Rvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 13:51:35 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:56846 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262397AbTI1Rve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 13:51:34 -0400
Date: Sun, 28 Sep 2003 19:51:26 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030928175126.GA22812@win.tue.nl>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <pan.2003.09.28.11.05.34.596021@dungeon.inka.de> <20030928123432.GA23693@redhat.com> <1064765545.741.69.camel@simulacron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064765545.741.69.camel@simulacron>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 06:12:26PM +0200, Andreas Jellinghaus wrote:

> Is there any tool that will change chs begin/end values
> from */255/63 geometry to */16/63 geometry? 

You could try sfdisk. Perhaps
	sfdisk -d /dev/hda > hda.pt
	sfdisk -H 16 -S 63 /dev/hda < hda.pt
will do the trick.
(Read the man page. Save your old table. Maybe -f is needed.)



